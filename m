Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AADA73FAE7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0LSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjF0LSW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 07:18:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE2F2947
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 04:18:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e12db357so4773759f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jun 2023 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687864686; x=1690456686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+436N+S1ESd5EPbNBsANPxxhM7KChbINfUFXT5IpyMQ=;
        b=gekr+ohwCIzlwofJvN6BQeFxZ8iW3QPMNeqfPVijyHJxzd/e6ArcaBlpYU4EnWE5n9
         aJbaFVcpHQ4mNPRY1h2UrR2ppkaPTYMaEIt0ENeaLc+qbld/GxEtpKYG65slkfaAhbWT
         1dx1oxB6gE4d+LJaPrWcctriXkwX263mE+6vrncSMGYd1t2xMgMJw+zwjbpkx9zMOK5a
         hGmY3vPD8Ud48+PiYSOq+jM+xozkzUlQjQxvUDO6kHE5CQFojkmwyN97OywdpKW6A8Ko
         h43m8yn8Iw7cXUI18HUvAbvs82lfQSgK/5BziPhHmbKn9TGatm5EXnE+DaHvcAkHxdNs
         UjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687864686; x=1690456686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+436N+S1ESd5EPbNBsANPxxhM7KChbINfUFXT5IpyMQ=;
        b=FhI3YQTtbOhRPyrgX2ty3prf2yBOhVdhJ7MNiFjgtd/aXRHyULrR6tatfqEkQH9feC
         +f/vj+4SrLN8BXW8KhfRW+zpy29ztN2Hbavr6f6jD9TPf39JvKaprDQ71N8Qi9cxmLhq
         /NMAikTGgy0bqWzNWeWWf8hT2TgiRChGfin5YjeCgMEHZCW68kmmk5w1HcnaV0zvkuHi
         BR4H6Lk+OFkHVnYuYIoe5EuDN6QOR++R+Si8dRCcAiauaBph8J5bK3gzNMdlHBRBz/C4
         HEtEXCFlkwCsd9CYOL/fXYQcw04gInFLEDyDd3HeR3DjcAQFafR+2slNCpZYOcqj1v1q
         ZmQg==
X-Gm-Message-State: AC+VfDyFO9W4JpqPqBjZ3S/TtEJA2sWXEq5rVJ8stkQ51Widk0xSyJZI
        MpzICWJ+5N4sTjgGWiFELeHCNmI8eJ6RWG39W00=
X-Google-Smtp-Source: ACHHUZ48asKXSrnaUDTeuUEr/zkyEsPg9S8hEgMPHuZw26rI/CCd2JXwbYPaaiU0H88k3eI2cKNNBw==
X-Received: by 2002:adf:f389:0:b0:313:f551:b037 with SMTP id m9-20020adff389000000b00313f551b037mr4832309wro.68.1687864686116;
        Tue, 27 Jun 2023 04:18:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b00313e2abfb8dsm9583227wrt.92.2023.06.27.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:18:04 -0700 (PDT)
Date:   Tue, 27 Jun 2023 14:18:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [bug report] PCI: rockchip: Fix window mapping and address
 translation for endpoint
Message-ID: <f84f0f6a-5b39-4004-b780-9884bca0811e@kadam.mountain>
References: <8d19e5b7-8fa0-44a4-90e2-9bb06f5eb694@moroto.mountain>
 <CAAEEuhrYr3ejHXH0TdvUJjXp+0cTnhsPJD6eUR1+Y=+ycjy+yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAEEuhrYr3ejHXH0TdvUJjXp+0cTnhsPJD6eUR1+Y=+ycjy+yA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 11:39:16AM +0200, Rick Wertenbroek wrote:
> On Tue, Jun 27, 2023 at 9:19 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Rick Wertenbroek,
> >
> > The patch dc73ed0f1b8b: "PCI: rockchip: Fix window mapping and
> > address translation for endpoint" from Apr 18, 2023, leads to the
> > following Smatch static checker warning:
> >
> >         drivers/pci/controller/pcie-rockchip-ep.c:405 rockchip_pcie_ep_send_msi_irq()
> >         warn: was expecting a 64 bit value instead of '~4294967040'
> >
> > drivers/pci/controller/pcie-rockchip-ep.c
> >     351 static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
> >     352                                          u8 interrupt_num)
> >     353 {
> >     354         struct rockchip_pcie *rockchip = &ep->rockchip;
> >     355         u32 flags, mme, data, data_mask;
> >     356         u8 msi_count;
> >     357         u64 pci_addr;
> >                 ^^^^^^^^^^^^^
> >
> >     358         u32 r;
> >     359
> >     360         /* Check MSI enable bit */
> >     361         flags = rockchip_pcie_read(&ep->rockchip,
> >     362                                    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> >     363                                    ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> >     364         if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
> >     365                 return -EINVAL;
> >     366
> >     367         /* Get MSI numbers from MME */
> >     368         mme = ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
> >     369                         ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
> >     370         msi_count = 1 << mme;
> >     371         if (!interrupt_num || interrupt_num > msi_count)
> >     372                 return -EINVAL;
> >     373
> >     374         /* Set MSI private data */
> >     375         data_mask = msi_count - 1;
> >     376         data = rockchip_pcie_read(rockchip,
> >     377                                   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> >     378                                   ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> >     379                                   PCI_MSI_DATA_64);
> >     380         data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
> >     381
> >     382         /* Get MSI PCI address */
> >     383         pci_addr = rockchip_pcie_read(rockchip,
> >     384                                       ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> >     385                                       ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> >     386                                       PCI_MSI_ADDRESS_HI);
> >     387         pci_addr <<= 32;
> >
> > The high 32 bits are definitely set.
> >
> >     388         pci_addr |= rockchip_pcie_read(rockchip,
> >     389                                        ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> >     390                                        ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> >     391                                        PCI_MSI_ADDRESS_LO);
> >     392
> >     393         /* Set the outbound region if needed. */
> >     394         if (unlikely(ep->irq_pci_addr != (pci_addr & PCIE_ADDR_MASK) ||
> >     395                      ep->irq_pci_fn != fn)) {
> >     396                 r = rockchip_ob_region(ep->irq_phys_addr);
> >     397                 rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> >     398                                              ep->irq_phys_addr,
> >     399                                              pci_addr & PCIE_ADDR_MASK,
> >     400                                              ~PCIE_ADDR_MASK + 1);
> >     401                 ep->irq_pci_addr = (pci_addr & PCIE_ADDR_MASK);
> >     402                 ep->irq_pci_fn = fn;
> >     403         }
> >     404
> > --> 405         writew(data, ep->irq_cpu_addr + (pci_addr & ~PCIE_ADDR_MASK));
> >
> > PCIE_ADDR_MASK is 0xffffff00 (which is unsigned int).  What Smatch is
> > saying here is that pci_addr is a u64 it looks like the intention was to
> > zero out the last byte, but instead we are zeroing the high 32 bits as
> > well as the last 8 bits.
> 
> Hello,
> You are right there is a problem.
> 
> The warning at line 405, however, seems to be a false positive. Because the
> mask is 0xffffff00 (which is unsigned int) and the ~ is applied before promotion
> this results in 0xff, which is then promoted to 0x00000000000000ff when applied
> to pci_addr so this is fine.
> 

Hm...  Yeah.  This warning message is quite old and I haven't thought
about it properly in some time.  Probably I should silence the warning
if BIT(31) is zero and only the lowest bits are 1.

I'll take a look at all these warnings again.

> What you describe about zeroing the upper 32 bits and not only the lower 8
> refers to line 399 where we apply the PCI_ADDR_MASK 0xffffff00 with the
> & operator to pci_addr, this is the real issue, as you said this
> zeroes the upper
> 32-bits, which is not the intended behavior. Thank you for pointing this out.

Heh.  No, I don't get credit for spotting line 399.  That's all you.

I don't know how to identify the issue on line 399 through static
analysis.  It think it's impossible to tell unintentional masking from
intentional masking on that line.

regards,
dan carpenter

