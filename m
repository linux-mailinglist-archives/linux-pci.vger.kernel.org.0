Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0BB5EDB4B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiI1LI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiI1LIO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:08:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDA1C408;
        Wed, 28 Sep 2022 04:06:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 10so19826358lfy.5;
        Wed, 28 Sep 2022 04:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ORb9sERSxMIv63iY+ckgWmXixVq6oKHLVhNgSaE2Ouo=;
        b=OZ0Q7JmMWDkTXmGsaWHP4llTAtzRToP5F5/dVmXLLkBcuJI63vOWSy90xyHt6Fq4ji
         VN7Hf8EHcqsj3ocRrDb9N3A6fkCcX/509Uo4VC/BqMDhY87kM+5DZXgwpRMu1EX90dLh
         0suF3LUJFha/80A1QHoMhdrkjLqCVo5fY/8ScHpEl4YZ57h8BogjDUDKYzcBqE5QJNdE
         xGyIkjD6MRkgmjRO/wLG5HN1FKBSNLVsZquXd2ffMqeTM6YhPEIfBhih9YFItk8IBCl6
         NaAfoIerSUV3Xr0kxYYCxnFWLorEETJmPhRQg5yMFWbLvsXBoeq8qvSgjPZ+2OlOpP+/
         MQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ORb9sERSxMIv63iY+ckgWmXixVq6oKHLVhNgSaE2Ouo=;
        b=Zg28FhTcd330Y2+D0fymablxg6VgrCrtoNHReiikjxu8cM8PvdHiX0m3YCz585t+xJ
         YHugXx0RDZcJFIcBRTSr9pNYiOUs/NkDRKtUrUcfcCQZRCpVr7suZM6aSP4FzsBQk9Ql
         f2/+Vdgcp+F7hrSQfZBfQNHsML6Q+AWsD9b3zwhnuvKGgx4URA+q1DIggLbGVEQktydO
         1FRiWuAdDLrQe8NXu0ZxF8UHR7y/1PP6eth8XhoFjbIwVgge97hM3dZgFZ6B5O7eTSYI
         QGw06DXOA3upUghrqiwFreV7/2lG1BcDEzduEq2zljVrafmNoUIWTC8AwkO8JFjiN2O8
         3gyQ==
X-Gm-Message-State: ACrzQf0O+5Fvq7NvE7wX0rA4NelNwSQRcmTwprH1iKUCKbUnkXXaunRR
        JCZhc77YOcu2SKvKTRGAFP0=
X-Google-Smtp-Source: AMsMyM4Dsy7g1ZA0z4B1Nrghs6PGyvITa8I/TiMTO6bSdlOIf8bjZ3vWDOaFkQ0AJceR/C7OBO/dHg==
X-Received: by 2002:a05:6512:3d87:b0:499:f2b6:7021 with SMTP id k7-20020a0565123d8700b00499f2b67021mr12387564lfv.103.1664363186093;
        Wed, 28 Sep 2022 04:06:26 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512115000b0048a9e18ae67sm446279lfg.84.2022.09.28.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:06:25 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:06:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status
 clearing api
Message-ID: <20220928110623.b3vocoubasrshyzk@mobilestation>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 06:59:37PM +0800, Zhuo Chen wrote:
> Hello.
> 
> Here comes patch v3, which contains some fixes and optimizations of
> aer api usage. The v1 and v2 can be found on the mailing list.
> 
> v3:
> - Modifications to comments proposed by Sathyanarayanan.

> Remove
>   pci_aer_clear_nonfatal_status() call in NTB and improve commit log. 

Failed to see who has requested that...

-Sergey

> 
> v2:
> - Modifications to comments proposed by Bjorn. Split patch into more
>   obvious parts.
> 
> Zhuo Chen (9):
>   PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>   PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>     uncorrectable error status
>   NTB: Remove pci_aer_clear_nonfatal_status() call
>   scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>   PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>   PCI/AER: Move check inside pcie_clear_device_status().
>   PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>   PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>   PCI/AER: Refine status clearing process with api
> 
>  drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>  drivers/pci/pci.c               |  7 +++--
>  drivers/pci/pci.h               |  2 ++
>  drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>  drivers/pci/pcie/dpc.c          |  3 +--
>  drivers/pci/pcie/err.c          | 15 ++++-------
>  drivers/pci/pcie/portdrv_core.c |  3 +--
>  drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>  include/linux/aer.h             |  4 +--
>  9 files changed, 44 insertions(+), 41 deletions(-)
> 
> -- 
> 2.30.1 (Apple Git-130)
> 
