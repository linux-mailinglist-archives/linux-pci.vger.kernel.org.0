Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD511C5139
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgEEIuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 04:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgEEIuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 04:50:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F7C061A0F;
        Tue,  5 May 2020 01:50:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so785154pgg.2;
        Tue, 05 May 2020 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUT+x7hZxMUvGW3rr8czLTgQ2d0DR57DmqDY2rfVL0Y=;
        b=NflrZ6asUfmK9JumWJZHBEycOshuaA5ju3WXPhemvZ9dMrEE7LKIPFUQaPaKX8tmFK
         ol00aw8+N8qn6lA0R1teCS8gelM0NzBudriV3SGL4EDGXIs14MyVihnsKhf+WNEZaA4D
         NtWiv+Pb6NzGrWdJHKWKCUrKOn1+v1r8jUZjoQHjyWipbhs90fh3A2RzhbSfNNDNz+xg
         /BO1yq3AqTjae+PqpbTQ1KljQaU89Rb8mu3EcAZSH+l2JS0lxQQhsnyoba0m/tMlAwho
         V4U3X9E9+VfwEOJCaF37+0M9zoGGEyDHV+e2W+Jd8hemBuJW4n3qz6jrTto/e5KQq5UV
         UQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUT+x7hZxMUvGW3rr8czLTgQ2d0DR57DmqDY2rfVL0Y=;
        b=ig8PtV+ZePur1YwVL8BYeqClzQ0NLjkNOmer0OcDGPBFUM65vaZr0kEpLv3hpEDE56
         LLb6XepzvC0GK/IkxPASo1Fc3Q03pSCTzKP4Qjkok5OAH/UllNXoyd6IDK6wXV5hLW9O
         aoj8UQ2CFL7fPg6LO+l3YeYM3xiKtEYB4d345CrEIfaH1JyH45rlaZ4/H1ouCVcC/OFj
         fW9VHfcvkdIIgOoOo8t6/m8QTItsNJtkmpR+4UIUuFv6mWabuNQkXxDpkgAB8AXI65TU
         xdFzWSsSh8tBiplAl5MeXWMD3+BfXPjKplmtynhy3HHSwRXa1DB3KZzdA/sKxtrBFbiz
         2Efw==
X-Gm-Message-State: AGi0PuYX65eCEApqpP8jJbhfYMwjLnZeRNdLD51uoc4SDvArxpmDDt7q
        ogD7+c/5dS1JEAVX8G44fBgYXZPWZsqpI4KpcCw=
X-Google-Smtp-Source: APiQypKyBHzdvd7RB1DYlovrB+TlIIGV74osSb9/piIwWudPnmMXM1wRoSUyIPXa+DymCx2DbpMszf2oZWhV5KHqYWI=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr2069291pfb.130.1588668602721;
 Tue, 05 May 2020 01:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200505013206.11223-1-david.e.box@linux.intel.com> <20200505013206.11223-2-david.e.box@linux.intel.com>
In-Reply-To: <20200505013206.11223-2-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 11:49:51 +0300
Message-ID: <CAHp75VcAA3DmjZnnpg=XdiKWtWWZBXeOguqEC7JSNYZmawCYSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pci: Add Designated Vendor Specific Capability
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy@infradead.org>,
        alexander.h.duyck@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 5, 2020 at 4:32 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> Add pcie dvsec extended capability id along with helper macros to

pcie -> PCIe

dvsec -> DVSEC (but here I'm not sure, what's official abbreviation for this?)

> retrieve information from the headers.



> https://members.pcisig.com/wg/PCI-SIG/document/12335

Perhaps

DocLink: ...

(as a tag)

>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  include/uapi/linux/pci_regs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..c96f08d1e711 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -720,6 +720,7 @@
>  #define PCI_EXT_CAP_ID_DPC     0x1D    /* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
> +#define PCI_EXT_CAP_ID_DVSEC   0x23    /* Desinated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX     PCI_EXT_CAP_ID_PL_16GT
> @@ -1062,6 +1063,10 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE        0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2          0x0c    /* Control 2 Register */
>
> +/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
> +#define PCI_DVSEC_HEADER1              0x4 /* Vendor-Specific Header1 */
> +#define PCI_DVSEC_HEADER2              0x8 /* Vendor-Specific Header2 */
> +
>  /* Data Link Feature */
>  #define PCI_DLF_CAP            0x04    /* Capabilities Register */
>  #define  PCI_DLF_EXCHANGE_ENABLE       0x80000000  /* Data Link Feature Exchange Enable */
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
