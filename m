Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97268AA3D
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjBDNgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Feb 2023 08:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjBDNge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2023 08:36:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612D76BA;
        Sat,  4 Feb 2023 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675517780; bh=r9QvehqIqzBr2NvH2mKbEppLZtReJvoWQN1vRm1gV/Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C4LFgo2hYF9MBip8dv3Z4pXK7YgF54jGwLuhZxYU0N1X4gDCvK8UQJ1zEDxnf3Q2k
         j7AQBpWSsVLCUtINgPlxxnTodZD0YgCWtLbRGLo2oSvVhlSCfPptlPjVJkR7Iw41m4
         QBy9au/rvJxnqmFMRPDxVVju4fG5Dvo6RdjuStlw5WMf0o6hfZPFjmjvrvQMPiavqC
         lB9QzC4aVPj4CFoHvy/IPSnDIwM/wPRJF7jEmC4i2taUAmzTdlTvmbC8QVhe4DFcF6
         OC83H/PElMdpArqQGBOvY3tZKX8XErvgcQxxA++x6hLdrWjOYReJnpI52hLGhuI+Zu
         wEzG4lfFKzfZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.151.109]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlGq-1okp9w0C5g-00drOq; Sat, 04
 Feb 2023 14:36:20 +0100
Message-ID: <fc19ceb2-5d64-2e33-b79c-9273925776b7@gmx.de>
Date:   Sat, 4 Feb 2023 14:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] Revert "fbdev: Remove conflicting devices on PCI bus"
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Cc:     Zeno Davatz <zdavatz@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20230203230909.2058637-1-helgaas@kernel.org>
 <20230204085018.GA31758@wunner.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230204085018.GA31758@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SgrWqkQ8IDCyK2Qh2jkdq0vcX6AYL07HOOVWEcgXEuTGv+jy5Ih
 n3dflAMIwY0Ge1CGZ+7Dwm3MgZMauwKjEs2HGsZIugCroBpkdnYQvOwMoE56Plzb56k2NzT
 nPddkZVWxQYeo2JLEohxAjlVdbbKKpHYxpCMAz8LtSDGySOjx3x2oOO+I8QQibyBBDOurHr
 Eoid7jtfgmgy/oW83h4BQ==
UI-OutboundReport: notjunk:1;M01:P0:ucLHiqoogJg=;OVtUjenNU/yt7e/hrrfbLWvCEBu
 V9Izx2uK5B0Ebpgydg3LGlJ5G542IzTTzy6CX31FuCqXaq3M718YvlrPEOLJQYhN9pXvuREn8
 KdS6liv+1qaHBrKT6DDqtFyCHkYr0/bv+bnFW4lEeRnPZBOcQ1lqYRJb3DYA09ZTOaqAyhsQ/
 coFCOZpl2LcM4puLMschZPiOTlAuQU1CJZoBRM5eh2KHhU4wQ0dGeF0DSjdsniXDN6p0LpZQU
 gvuU0Ad7bwICep7Pq1Co22t5WERHlb5jIXsx9Gkaly+P9s1r/WYvmLuP1cVb9/YeX7RDrdD0P
 cbqIbTwWEBc0mIyu3Rl1HrPNbpw9K3gMF1n7mIIY0+M/k0UhzmNq9CRvmfDHG32ODp/EdSVsb
 6Min7IPrglxxhhOVwm/xrz8Ad1+tDGKtzb551TQWLfHurZd7LN6FAzcJf501HobAH+fWbryEa
 NXeA2ZNp62LzHBJEBAG4/TbYD1aFxGIKaQlfQYoTGk3F27zyeAtJkyLzB4RfBA0ler2m+aD5+
 jduB4Lcf5UPhSnb4zI0emrAs+LgA57siMhPpermNGtDs56DW1p0x7pmFdpLhP7SJGjQVWD7Rt
 +dwP7YgKYFLzFGmx2g652ILhzWIqrLLFsoI6isKiY69dG9989PWhpFvYPfFgpR1ZJSAroPrP8
 aYEEYc/TF9lYmf+AQcJ7bst8vURH6B1QkuzDG+C1kTDoinDj8l3j0RAANAjUjAvNPXVFbUoAr
 8NIBI073CRLxNf2yGNLx5pm3bWf7thxJJpafj/Srrc2PLdtkm4qUmEVV3IsURe09a4s6Y5D9r
 X5jm4J1CiGG0TtD6EiKT+1DYZViTAeeR9Do0MHQ3BNlxMsH7iRvrInUe4VKHDfO2AGsDSlHtz
 kC1MBdHE+LSJdJTCEa+U0mUw8h61fdjXnAeHC0bOdc0+CNSKFRCghN0UW46THeEPnHX7Kg8Va
 xPV3+hVD0pCZj+TEnSOt7qAq8Ag=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/4/23 09:50, Lukas Wunner wrote:
> On Fri, Feb 03, 2023 at 05:09:09PM -0600, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> This reverts commit 145eed48de278007f646b908fd70ac59d24ed81a.
>>
>> Zeno Davatz reported that 145eed48de27 ("fbdev: Remove conflicting devi=
ces
>> on PCI bus") caused a console hang.  The machine was actually still usa=
ble
>> via ssh, etc., but there was no activity on the console.
>>
>> Reverting 145eed48de27 for the nvidiafb on that system fixed the proble=
m.
>>
>> Revert 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus") si=
nce
>> we don't know what caused the problem.
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216859
>
> Shouldn't that rather be:
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216859
> Fixes: 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus")
> Cc: stable@vger.kernel.org # v6.1+
>
> ?

The original patch is related to drm, and came in through the drm-misc
tree, so please drm folks, take such revert through the drm-misc
tree (if the patch is ok) as well.

Thanks,
Helge


>> Reported-by: Zeno Davatz <zdavatz@gmail.com>
>> Tested-by: Zeno Davatz <zdavatz@gmail.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> ---

