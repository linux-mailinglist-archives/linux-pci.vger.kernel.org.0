Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41106476F1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 21:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLHUE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 15:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHUE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 15:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3F6932E
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 12:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670529816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9vLWKI5zlvwnkCSzUEhWjZnJmVEh2oFq9A6y7IkT2U=;
        b=UwCFtErFUf3W1sQ+BbsQWZqeuX9YXqVFdXkvC4Jh69vfuu1XF6aP1huWEFRn1SYVXvSGLz
        EtN/9/mmT1AJE1pd2BhJ2zWROT64NK/LsfnK8JXAahaC6yZbjIli5PZY8PF+wJQivt++ff
        Eniq9nTOVYXbPS0IRmfn8IoW4ewaTCY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-dt6u0uBePqKfJz44y4itDA-1; Thu, 08 Dec 2022 15:03:35 -0500
X-MC-Unique: dt6u0uBePqKfJz44y4itDA-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402359200b004635f8b1bfbso106844edc.17
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 12:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9vLWKI5zlvwnkCSzUEhWjZnJmVEh2oFq9A6y7IkT2U=;
        b=ovzyS9WlKFWNXMCPthCuFTjGHaTuHaEIr1UILCuSsT23+VfR878REFnpeKtNot5t0O
         rkDNF855w2SlGcfa6zSibU5J5cbqsX75gL162Pk8zgrn/u+Mx+SsM3EQ4tdr+pvIZnGa
         u9XlIoUolelm948MkphgvIWZIvT0PcfNmSxGuzUaqISfN7tRQN5DnuD4dwM1BKDkZqVW
         qkXhtkdem0hZExops/MxKSIg4KIi47wp7zqpQeUR4eYoR2QBQ4F9oKNkE2IKZTd3TrhV
         Mt8faE5B0bosW+3SRlt8RbsRhQjSiYWTQigjOrRCixdid19SveF5ZmfCgIB9XBgMgl1e
         UDzA==
X-Gm-Message-State: ANoB5pmm0DBNlhc2lHEJUP/A7oePuBa1KaApc7cQ4xrh54tnyv57/qGj
        RC4uFvxk5DkTfd1UbVgGN+tc9WxxOvRUMmn3iIlzMF0bXDDNkuJUQ4207wQ6P2ahawLqhyX91nI
        DIacDGBbRDTfvas00ujvA
X-Received: by 2002:a17:907:8746:b0:7bc:1e7e:6b8e with SMTP id qo6-20020a170907874600b007bc1e7e6b8emr2903731ejc.43.1670529813870;
        Thu, 08 Dec 2022 12:03:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4cUGx75KUvScjrVVvtkbvf6iEhGna90EyKHgCQUNzFRE45kR7HRKQyedocHZ21uRtpHRN8tw==
X-Received: by 2002:a17:907:8746:b0:7bc:1e7e:6b8e with SMTP id qo6-20020a170907874600b007bc1e7e6b8emr2903713ejc.43.1670529813704;
        Thu, 08 Dec 2022 12:03:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906a10100b0078d3f96d293sm3330021ejy.30.2022.12.08.12.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 12:03:33 -0800 (PST)
Message-ID: <2ee3cee0-965a-a36e-da2c-d671b102c8d2@redhat.com>
Date:   Thu, 8 Dec 2022 21:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 0/4] PCI: Continue E820 vs host bridge window saga
Content-Language: en-US, nl
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221208190341.1560157-1-helgaas@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221208190341.1560157-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/8/22 20:03, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When allocating space for PCI BARs, Linux avoids allocating space mentioned
> in the E820 map.  This was originally done by 4dc2287c1805 ("x86: avoid
> E820 regions when allocating address space") to work around BIOS defects
> that included unusable space in host bridge _CRS.
> 
> Some recent machines use EfiMemoryMappedIO for PCI MMCONFIG and host bridge
> apertures, and bootloaders and EFI stubs convert those to E820 regions,
> which means we can't allocate space for hot-added PCI devices (often a
> dock) or for devices the BIOS didn't configure (often a touchpad)
> 
> The current strategy is to add DMI quirks that disable the E820 filtering
> on these machines and to disable it entirely starting with 2023 BIOSes:
> 
>   d341838d776a ("x86/PCI: Disable E820 reserved region clipping via quirks")
>   0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting in 2023")
> 
> But the quirks are problematic because it's really hard to list all the
> machines that need them.
> 
> This series is an attempt at a more generic approach.  I'm told by firmware
> folks that EfiMemoryMappedIO means "the OS should map this area so EFI
> runtime services can use it in virtual mode," but does not prevent the OS
> from using it.
> 
> The first patch removes large EfiMemoryMappedIO areas from the E820 map.
> This doesn't affect any virtual mapping of those areas (that would have to
> be done directly from the EFI memory map) but it means Linux can allocate
> space for PCI MMIO.
> 
> The rest are basically cosmetic log message changes.
> 
> Changes from v1 to v2:
> - Remove only large (>= 256KB) EfiMemoryMappedIO areas from E820 to avoid
>   the Lenovo X1 Carbon suspend/resume problems.  This machine includes
>   64KB of non-window space in the PNP0A03 _CRS, and a corresponding
>   EfiMemoryMappedIO area seems to be the only clue to avoid it (see
>   https://bugzilla.redhat.com/show_bug.cgi?id=2029207).  Interdiff below.

Thanks, v2 looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

for the series.

I have also started a Fedora kernel test-build with this series added
and asked the reporters of the ideapad touchpad + x1 carbon suspend/resume:

https://bugzilla.redhat.com/show_bug.cgi?id=1868899
https://bugzilla.redhat.com/show_bug.cgi?id=2029207

bugs to test.

Regards,

Hans



> Bjorn Helgaas (4):
>   efi/x86: Remove EfiMemoryMappedIO from E820 map
>   PCI: Skip allocate_resource() if too little space available
>   x86/PCI: Tidy E820 removal messages
>   x86/PCI: Fix log message typo
> 
>  arch/x86/kernel/resource.c  |  8 +++++--
>  arch/x86/pci/acpi.c         |  2 +-
>  arch/x86/platform/efi/efi.c | 46 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |  4 ++++
>  4 files changed, 57 insertions(+), 3 deletions(-)
> 

