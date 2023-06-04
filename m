Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5819F721AFB
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFDXHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFDXHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 19:07:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC38D2;
        Sun,  4 Jun 2023 16:07:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso461893e87.1;
        Sun, 04 Jun 2023 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685920064; x=1688512064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwLcOmYSCHnciiTrmwp/dF1NG1ZiZ+r/NeCx4fwaUHI=;
        b=QCnkt9pJq7WxTPkKPOBn8SoKUFsjTL5sFTnTq5H6XWu8o9/JwD+9IK11OzXKeE6QLw
         8OwzpjxyXX331JrCI/4NX5xSj2gV6/Rx01V2h9Iay2xYN7vrhMJmfitg0orlAM+gheJc
         eiHFz/j4dD0qO6Umfmzx3mMnP2UayaMLQ+dJtxU+xIxv6wXsDECjx3m0Zhz88F8qnYAE
         FoUh3zRLqFd/zA00USokvAdoBJi5nUAFz/kjV9p2x5ulWdTVtSa/gOCgFw1CankE1U3Y
         JrM5LhpfdMkEJPWVC/dqjHJNWOocVAIfiS7Vsz+/Rru4tloIobo9jLfOB7mOk9zgjEy0
         WC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685920064; x=1688512064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwLcOmYSCHnciiTrmwp/dF1NG1ZiZ+r/NeCx4fwaUHI=;
        b=aYGXiCtFPfD0iSn9EbFQGRPg2bbsuYmU8s5jPwJ63QRYvPAUGL3PnDZI0/RsLCsqYA
         JipR0y1sa7Zew6YKXhQs46rs2nD1PCHRp0Fdgw0YXGY3MYMgO64Ed3zoCXiuEcX3QwSN
         z+5bzjiQMTGDRLkV/s0SLgcgGIVcsaD1dZuBfm5LxFIltRTO9a8wXpu9ISGXsVOD3LgM
         kDX1baAhPp8cJNwa1sT5ZtUzSWxxIcO5Dsy7lZfVlLlcqnzvdw6KtNK3mjcoWwUh6spX
         pO08sVCf4fDlCTl/gvMixJg5NY4GHSgWHvOwkyq/Oudj7NCb4klIXeZZmwCvwq+YmHv5
         1PDw==
X-Gm-Message-State: AC+VfDzlB0l8+5E2OuYZrwFjM65gduzIgmSwbQFMlsgZpNngZwNaWp9E
        ftobQHpgfY7813G9ISbE1V0=
X-Google-Smtp-Source: ACHHUZ6oKTlkUeLJtYCcCG67VWEvQ2tfDxFh+oLdXO/CCRchFe3Sm8v+yohx97eSJG69wNjsPm4DSw==
X-Received: by 2002:ac2:5303:0:b0:4f1:b3ab:cd61 with SMTP id c3-20020ac25303000000b004f1b3abcd61mr3920672lfh.61.1685920063744;
        Sun, 04 Jun 2023 16:07:43 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f1d884a4efsm912195lfm.242.2023.06.04.16.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:07:43 -0700 (PDT)
Date:   Mon, 5 Jun 2023 02:07:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Message-ID: <20230604230740.criuymkykrq54oln@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:15PM +0900, Yoshihiro Shimoda wrote:
> Add "Message Routing" and "INTx Mechanism Messages" macros to send
> a message by a PCIe driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2475098f6518..67badc40e90b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -11,6 +11,24 @@
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
>  

> +/* Message Routing */

Call it "Implicit Message Routing (r[2:0])" as per the specification.

> +#define PCI_MSG_ROUTING_RC	0
> +#define PCI_MSG_ROUTING_ADDR	1
> +#define PCI_MSG_ROUTING_ID	2
> +#define PCI_MSG_ROUTING_BC	3
> +#define PCI_MSG_ROUTING_LOCAL	4
> +#define PCI_MSG_ROUTING_GATHER	5

IMO prefix like this PCI_MSG_TYPE_R_{RC,ADDR,ID,BC,...} would be a bit
better since it would indicate that this routing flags are a sub-field of
the Message Type field. Bjorn?

> +
> +/* INTx Mechanism Messages */
> +#define PCI_CODE_ASSERT_INTA	0x20
> +#define PCI_CODE_ASSERT_INTB	0x21
> +#define PCI_CODE_ASSERT_INTC	0x22
> +#define PCI_CODE_ASSERT_INTD	0x23
> +#define PCI_CODE_DEASSERT_INTA	0x24
> +#define PCI_CODE_DEASSERT_INTB	0x25
> +#define PCI_CODE_DEASSERT_INTC	0x26
> +#define PCI_CODE_DEASSERT_INTD	0x27

IMO Prefix PCI_MSG_CODE_... would be a bit more descriptive since per
the specification the respective message field is called "Message
Code" and not just "Code". Bjorn?

-Serge(y)

> +
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
>  
> -- 
> 2.25.1
> 
