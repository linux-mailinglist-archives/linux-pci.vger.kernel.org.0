Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32C48C41C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 13:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353202AbiALMjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 07:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353199AbiALMjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 07:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641991150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgxkQSZ8b+aml4o8B8fyZl110EtbOEBaG+x48NPMSQY=;
        b=dcepwh7ZoeZOlAVkzt7yZ2mOFSP0oMf11W63tgZCZUG6Sb8ofELAZemVLmc+PP33Dvgll0
        vpGsLjEB31FWRjfUjr3OicrYdhPR5OzE9AwjcR60nFF23I891X4WfMFCj4vhtmIocEj53K
        msTwI15hLykiiYkx+jy4qzufeiCjv4o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6--9iOSxYrMPmUFNE5eFlRpg-1; Wed, 12 Jan 2022 07:39:09 -0500
X-MC-Unique: -9iOSxYrMPmUFNE5eFlRpg-1
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso2199874edw.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 04:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UgxkQSZ8b+aml4o8B8fyZl110EtbOEBaG+x48NPMSQY=;
        b=Lg0w7ob9GDFPtD/zCd9E5FrLx2ezgdTTjKgefPEQr2TXrmDMWsK0hbI5lRxfkBnW+X
         edKk+Qeezed5R6BFldNu0sdRbnl5F5hVenqbqKsTtDN16ET6kd3JZNtcHTG1hL6e78X0
         4AAYEOwjojQQiYAE1o1uOwGOCGy44GA+K+rDXNHOIm2IhiAkn0ow6fGjar0Q7qG+GcwW
         ZBbVFY64gstzhpQjNdRuhTmMzoswNlLOBUynZkAiTr6NBtK7Sgx+BG4dfHdUmGbYW/yI
         wy9qy+SYmu11BsJ/FiLNUhxz2RRBn5/l0Iwu++BaIHRJ2s/icqYmy9AIy+h/+YHxAmgB
         WFKQ==
X-Gm-Message-State: AOAM53020RXIBcWD8OQ5TRnlZfZmwF8tEok9rJzIpUBoGxU+25+j/Pnv
        9tOpZE7X6G4NHaPQqWpMjPcm78hdL2z9W2oKk5Op3xjE6wWggWzjl2zFfIpMgvSemrMq+sdbdyf
        1At2ftH6bDXaWDbP6QZ9p
X-Received: by 2002:a17:906:e92:: with SMTP id p18mr7337957ejf.616.1641991148440;
        Wed, 12 Jan 2022 04:39:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC2/nQaMaaKTnPi1rIa/aVuKDMqkLTK2uQQ1sf6y3TCcFwHb5tRonhXHBdw539xBPFPK4atg==
X-Received: by 2002:a17:906:e92:: with SMTP id p18mr7337944ejf.616.1641991148243;
        Wed, 12 Jan 2022 04:39:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d15sm6164477edv.44.2022.01.12.04.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 04:39:07 -0800 (PST)
Message-ID: <60b38764-835c-83dd-8fb9-b7d6a22e70b6@redhat.com>
Date:   Wed, 12 Jan 2022 13:39:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH resend v2] PCI: pciehp: Use
 down_read/write_nested(reset_lock) to fix lockdep errors
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <20211217141709.379663-1-hdegoede@redhat.com>
 <20220111171447.GA152379@bhelgaas> <20220112082801.GA19022@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220112082801.GA19022@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/12/22 09:28, Lukas Wunner wrote:
> On Tue, Jan 11, 2022 at 11:14:47AM -0600, Bjorn Helgaas wrote:
>> On Fri, Dec 17, 2021 at 03:17:09PM +0100, Hans de Goede wrote:
>>> Use down_read_nested() and down_write_nested() when taking the
>>> ctrl->reset_lock rw-sem, passing the number of PCIe hotplug controllers in
>>> the path to the PCI root bus as lock subclass parameter. This fixes the
>>> following false-positive lockdep report when unplugging a Lenovo X1C8 from
>>> a Lenovo 2nd gen TB3 dock:
> [...]
>> Applied to pci/hotplug for v5.17, thanks, Hans!
> 
> I've realized only now that Hans reported this issue already in August 2020
> and opened a bugzilla for it:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208855

Ah I completely forgot about having filed that bug, good catch.

> The status can now be set to RESOLVED FIXED.  I don't have permission
> to do that but perhaps either of you, Bjorn or Hans, has?

I have added a comment and closed the bug now. Note that you can email
the kernel.org admins with your bugzilla login + a friendly requests
to give you some more bugzilla rights. I did that a while ago when
I hit similar issues doing triage of bugzilla.kernel.org bugs.

> Also, the commit could optionally be amended with a Link: tag to that
> bugzilla entry.

There isn't really any new info in the bugzilla though, so I guess
the commit is fine as is. With that said if Bjorn wants to add it
that is fine too of course.

Regards,

Hans

