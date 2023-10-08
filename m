Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4727BD066
	for <lists+linux-pci@lfdr.de>; Sun,  8 Oct 2023 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbjJHVv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Oct 2023 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJHVv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Oct 2023 17:51:27 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0EB3;
        Sun,  8 Oct 2023 14:51:19 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 5769E623B2;
        Mon,  9 Oct 2023 00:51:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b6af::1:24] (unknown [2a02:6b8:b081:b6af::1:24])
        by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id EpjYFZBOlKo0-yX8dmxAB;
        Mon, 09 Oct 2023 00:51:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
        s=default; t=1696801875;
        bh=awdEI7BOcGPprVM/3CfxRB5xiwqGUlBHRGFcX7oUSEQ=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=1PkLZQSwcgjw0NKUEL5quf1CLlsPk8ZZIFP0bp8ZxIVKo8RTPM4U+azlz6gPOKPhp
         AOt8F7HXEBAndI4Ig7CM4MkW/u9MopJO7JHioHCtrigZiIVlmMXjGABC2tiAPKdwQ6
         qTktzzKKqSezN37JUKFLwDmbe9IDhdjzxTsD0788=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <2c7bfe48-b2f5-41a2-81b9-34a49c139d87@yandex-team.ru>
Date:   Mon, 9 Oct 2023 02:51:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: Implement custom llseek for sysfs resource
 entries
Content-Language: ru, en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <2023092241-obedient-squirt-966c@gregkh>
 <20230925084013.309399-2-valesini@yandex-team.ru>
 <2023100503-change-nimbly-8c58@gregkh>
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <2023100503-change-nimbly-8c58@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05.10.2023 16:41, Greg Kroah-Hartman wrote:
> On Mon, Sep 25, 2023 at 11:40:13AM +0300, Valentine Sinitsyn wrote:
>> Since commit 636b21b50152 ("PCI: Revoke mappings like devmem"), mmappable
>> sysfs entries have started to receive their f_mapping from the iomem
>> pseudo filesystem, so that CONFIG_IO_STRICT_DEVMEM is honored in sysfs
>> (and procfs) as well as in /dev/[k]mem.
>>
>> This resulted in a userspace-visible regression:
>>
>> 1. Open a sysfs PCI resource file (eg. /sys/bus/pci/devices/*/resource0)
>> 2. Use lseek(fd, 0, SEEK_END) to determine its size
>>
>> Expected result: a PCI region size is returned.
>> Actual result: 0 is returned.
>>
>> The reason is that PCI resource files residing in sysfs use
>> generic_file_llseek(), which relies on f_mapping->host inode to get the
>> file size. As f_mapping is now redefined, f_mapping->host points to an
>> anonymous zero-sized iomem_inode which has nothing to do with sysfs file
>> in question.
>>
>> Implement a custom llseek method for sysfs PCI resources, which is
>> almost the same as proc_bus_pci_lseek() used for procfs entries.
>>
>> This makes sysfs and procfs entries consistent with regards to seeking,
>> but also introduces userspace-visible changes to seeking PCI resources
>> in sysfs:
>>
>> - SEEK_DATA and SEEK_HOLE are no longer supported;
>> - Seeking past the end of the file is prohibited while previously
>>    offsets up to MAX_NON_LFS were accepted (reading from these offsets
>>    was always invalid).
>>
>> Fixes: 636b21b50152 ("PCI: Revoke mappings like devmem")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> I'll take these now, for 6.7-rc1, but not mark them as fixes or cc:
Thanks, appreciated.

> stable as this is a new functionality, the code has never worked for
> lseek on these files so it's not like anything was broken :)
In fact, lseek() on PCI resource files in sysfs was broken since commit 
636b21b50152. That was the reason why I started to investigate the 
issue: one of our applications stopped working after a kernel update.

I'm not hundred percent sure if it belongs to stable, but it does fix a 
user-visible regression.

Best,
Valentin
