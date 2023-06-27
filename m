Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218C673F54F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjF0HTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 03:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjF0HTT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 03:19:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F761211E
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 00:19:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e1c27476so2439513f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687850352; x=1690442352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dE2WHxlRabkmNFV6UQgAAK/SiSiy26ezXn6XoDTEYXk=;
        b=deALLBrN428hJg1qqaUWNAHRcQ17iND40MTSLcNgUi3Js3F4vL2Ug1Qurimx1w4oKG
         MWTUtPhR+HpvvRD6M0GwPgEAWmjCFIzezNqD1m4m2Hai0+b5OzivKSMNugustXd4Sh0v
         IWGbPyG+IcphHzZSXHcuGPgYEO/7zUBrhLRMLSDGYIGLtmTCyz4Tt8ExCKuIl4P31RC+
         3FWlorPcSR+ZPWtThsjudA6h1kjmcM7z2Klc7cKaymiTz175NNJ8tGfHxA+utOlt+6gg
         toGzD4l7095jdVUzttaTuCqj1dwhMcn116TKMCTRCHtQ/m/kFn+pEDQ05R1RZPTOIxKc
         +wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687850352; x=1690442352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dE2WHxlRabkmNFV6UQgAAK/SiSiy26ezXn6XoDTEYXk=;
        b=PvKIcze2APOC8PLLrrGOjAUm0UahrrI7yU8M3lCq6cHjv4jwfI2usFViC8Rdg1EHes
         kAhA1acNCG4ddNzmgH29dquRhfGlw21C0i0SM7wmvUnvtFlp1Xzl9RWpKVWlxKNk8Jpc
         QotcCui3TvuHN8hcT6HnlH1abyBTKEjucRwTmbCXPIyzG7CaefyLfXwFPG+i9z08xpdO
         YhazV8mr5hDgAF6iHmPKXi2S3kYOkR+uBr/deVT5qnHbRMYY6c/7YNTjhxoB9bZgetC2
         WN5FcISouTT++PpxT8aCD+AY/a+0V3dzMvQ8IxO33QnR4Uh1xGAcDODcruOBo9ns9lwT
         9M1g==
X-Gm-Message-State: AC+VfDxrYD4bL+99EtUAcucfHgmZj7Poq20/883rU4+SqE7/YXdS80CJ
        bVgQ1gmxUmafWoo6E3Td2VmHTg==
X-Google-Smtp-Source: ACHHUZ5Z8MEBV48V+8AfeXL908qVRSw1/sNUR/Q7UQ+UcVVQEwKyGP5n8V1/y1oSMwcEIFzjc/ku3g==
X-Received: by 2002:a5d:6644:0:b0:313:eeb0:224c with SMTP id f4-20020a5d6644000000b00313eeb0224cmr6072227wrw.28.1687850352570;
        Tue, 27 Jun 2023 00:19:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q5-20020a05600000c500b0031401bd6387sm478954wrx.102.2023.06.27.00.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:19:11 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:19:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     rick.wertenbroek@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [bug report] PCI: rockchip: Fix window mapping and address
 translation for endpoint
Message-ID: <8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rick Wertenbroek,

The patch dc73ed0f1b8b: "PCI: rockchip: Fix window mapping and
address translation for endpoint" from Apr 18, 2023, leads to the
following Smatch static checker warning:

	drivers/pci/controller/pcie-rockchip-ep.c:405 rockchip_pcie_ep_send_msi_irq()
	warn: was expecting a 64 bit value instead of '~4294967040'

drivers/pci/controller/pcie-rockchip-ep.c
    351 static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
    352                                          u8 interrupt_num)
    353 {
    354         struct rockchip_pcie *rockchip = &ep->rockchip;
    355         u32 flags, mme, data, data_mask;
    356         u8 msi_count;
    357         u64 pci_addr;
                ^^^^^^^^^^^^^

    358         u32 r;
    359 
    360         /* Check MSI enable bit */
    361         flags = rockchip_pcie_read(&ep->rockchip,
    362                                    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
    363                                    ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
    364         if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
    365                 return -EINVAL;
    366 
    367         /* Get MSI numbers from MME */
    368         mme = ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
    369                         ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
    370         msi_count = 1 << mme;
    371         if (!interrupt_num || interrupt_num > msi_count)
    372                 return -EINVAL;
    373 
    374         /* Set MSI private data */
    375         data_mask = msi_count - 1;
    376         data = rockchip_pcie_read(rockchip,
    377                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
    378                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
    379                                   PCI_MSI_DATA_64);
    380         data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
    381 
    382         /* Get MSI PCI address */
    383         pci_addr = rockchip_pcie_read(rockchip,
    384                                       ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
    385                                       ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
    386                                       PCI_MSI_ADDRESS_HI);
    387         pci_addr <<= 32;

The high 32 bits are definitely set.

    388         pci_addr |= rockchip_pcie_read(rockchip,
    389                                        ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
    390                                        ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
    391                                        PCI_MSI_ADDRESS_LO);
    392 
    393         /* Set the outbound region if needed. */
    394         if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
    395                      ep->irq_pci_fn != fn)) {
    396                 r = rockchip_ob_region(ep->irq_phys_addr);
    397                 rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
    398                                              ep->irq_phys_addr,
    399                                              pci_addr & PCIE_ADDR_MASK,
    400                                              ~PCIE_ADDR_MASK + 1);
    401                 ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
    402                 ep->irq_pci_fn = fn;
    403         }
    404 
--> 405         writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));

PCIE_ADDR_MASK is 0xffffff00 (which is unsigned int).  What Smatch is
saying here is that pci_addr is a u64 it looks like the intention was to
zero out the last byte, but instead we are zeroing the high 32 bits as
well as the last 8 bits.

    406         return 0;
    407 }

regards,
dan carpenter
