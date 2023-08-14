Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65677BDD0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHNQVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjHNQUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 12:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F94127;
        Mon, 14 Aug 2023 09:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 018F161538;
        Mon, 14 Aug 2023 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39144C433C7;
        Mon, 14 Aug 2023 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692030030;
        bh=Lp5NQoRVJVYBTk1cBJi4eKGlFprUMKj5hMwOdNNo6ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eeAsAIkFPMH+kEjmqNPcPblqMWg2Ts9xgNK61GUnTB3tgJTInuIqg5T5tcS9Box2Z
         f7JRtsnAVlwrbEwnkwlmaRuw2vOGtnfbjD4YdUqjZW+hvRjng/jxeURysEe2ciW9Rb
         t4r94xuf/hGLhMm8vJLcywT5LuxXYxWCuhZjnpPV+jlujkp2MK494V/jei5XujytG1
         yYLbuM5YBkLreu8EeHEaR6H2g0D8+o7EJ4oM1nQpcAG/xGZcS4SIXpCGQhOANgd2NW
         9iUknpfBwcCjiBMYFbV6RR62NuYOcM/+R8+uw3Vbj67XELNj7E8Ndh1vL1Cmi8puvW
         USD+TWdnIT8vQ==
Date:   Mon, 14 Aug 2023 11:20:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     deloptes <emanoil.kotsev@deloptes.org>
Cc:     linux-pci@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT
 SAS
Message-ID: <20230814162028.GA176555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uba6vj$10n6$1@ciao.gmane.io>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc mptsas folks]

On Sun, Aug 13, 2023 at 11:15:31AM +0200, deloptes wrote:
> I hope I am in the right news group. If not please point me to a place where
> someone can give me an advice in which direction I could look for an
> answer.

Thanks for your question.  I added the mptsas maintainers and related
mailing lists.

> I've been using the below mentioned board (see dmidecode) with the below
> mentioned SAS controllers (see lspci) for many years with normal
> (rotating/spinning) disk drives.
> I now bought 2 SSD disks to replace 2 of the spinning once and I was
> surprised to find out that the older disks are using 3Gb/s transfer rate
> while the SSDs are using 1.5Gb/s. The SSDs are reporting SATA 3.3 (see
> below)
> 
> In the mptsas driver I see 3 and 6 but no 3.3 or similar. 
> 
> https://github.com/torvalds/linux/blob/ae545c3283dc673f7e748065efa46ba95f678ef2/drivers/message/fusion/mptsas.c#L3087C1-L3111C3
> 
> If I understand correctly the rate is negotiated by the controller and the
> mobo. I am wondering where could be the problem. Is it really matter of
> negotiation i.e. the driver does not understand 3.3 or a technical
> constrains/incompatibility at 3Gb/s?

It looks like your SSDs support SATA r3.3 and are capable of 6.0 Gb/s,
and the SAS1068E SAS controller is limited to 3.0 Gb/s [1].  I would
expect them to negotiate 3.0 Gb/s (as your older drives did) and
you're only seeing 1.5 Gb/s.  Sorry, I guess I just restated your
whole question ;)

I don't know why that would be.  Are there any hints in the dmesg log?
Can you collect the complete dmesg log with the old drives and again
with the new SSDs so we can compare them?  I assume you have good
cables?  I assume the same cables worked at 3.0 Gb/s with the old
drives.

I would *expect* that SATA r3.3 would be completely backwards
compatible, so since mptsas worked just fine at 3.0 Gb/s with the old
SATA r3.0 drives, it should also work just fine at 3.0 Gb/s with the
new SATA r3.3 drives.  But I have no actual knowledge about that.

[1] https://docs.broadcom.com/doc/12352180

> Last question: If I would have to replace the controllers, what controller
> would be recommended?
> 
> Thank you in advance
> 
> BR
> 
> 
> # lspci
> 01:00.0 SCSI storage controller: Broadcom / LSI SAS1068E PCI-Express
> Fusion-MPT SAS (rev 08)
> 08:00.0 SCSI storage controller: Broadcom / LSI SAS1068E PCI-Express
> Fusion-MPT SAS (rev 08)
> 
> # dmidecode
> 
> Handle 0x0002, DMI type 2, 15 bytes
> Base Board Information
>         Manufacturer: ASUSTeK COMPUTER INC.
>         Product Name: M5A97 EVO R2.0
>         Version: Rev 1.xx
> 
> Handle 0x0028, DMI type 9, 17 bytes
> System Slot Information
>         Designation: PCIEX16_2
>         Type: x16 PCI Express
>         Current Usage: Available
>         Length: Short
>         ID: 3
>         Characteristics:
>                 3.3 V is provided
>                 Opening is shared
>                 PME signal is supported
>         Bus Address: 0000:00:1c.5
> 
> 
> 
> # smartctl
> 
> === START OF INFORMATION SECTION ===
> Model Family:     WD Blue / Red / Green SSDs
> Device Model:     WDC  WDS200T1R0A-68A4W0
> ...
> Firmware Version: 411010WR
> User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> Sector Size:      512 bytes logical/physical
> Rotation Rate:    Solid State Device
> Form Factor:      2.5 inches
> TRIM Command:     Available, deterministic, zeroed
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ACS-4 T13/BSR INCITS 529 revision 5
> SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 1.5 Gb/s) <<<<<<<<<<<< HERE
> Local Time is:    Sun Aug 13 10:38:11 2023 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Western Digital Red
> Device Model:     WDC WD20EFRX-68EUZN0
> ...
> Firmware Version: 82.00A82
> User Capacity:    2,000,398,934,016 bytes [2.00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    5400 rpm
> Device is:        In smartctl database [for details use: -P show]
> ATA Version is:   ACS-2 (minor revision not indicated)
> SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 3.0 Gb/s) <<<<<<<<<<<< HERE
> Local Time is:    Sun Aug 13 10:38:11 2023 CEST
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> 
> -- 
> FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0
> 
