Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C34E69F5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353615AbiCXUt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354881AbiCXUs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 16:48:58 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5477EB0D;
        Thu, 24 Mar 2022 13:47:25 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so984551ooi.1;
        Thu, 24 Mar 2022 13:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kT18hQ0qUgvwsPrJ+y8XROBC3+T9vZQQezhw/vfNsVw=;
        b=Sswe00zdLSW58ZFNXIdFVTGgEbb/mCCcMiORiOjrc6lKaV0k7HSGdIdOm5FQc287Xw
         9iC/qWdmEBRSlka3RlsyQw9iAi7YIfGbmA2TnVGV4qzBzMghpmua6QXa5jgNSa2Mgyoa
         1rxEEgpBDo3mF395EJDGl0oozcM2spOLndglKPfC3D1Jjwqy3sgvk+VkQQgHXjkH34ME
         HkWHJN/+Ddkrxjd04RcCvBFNw4oNHnPZs9aUapEQE8/geRKGCXrJxRZ2cxj5CqM5jc2p
         zPn19ACiSpNbxC9TqzOg2OTepHdHDdWpmrtK5wJ3MLqJHzPBrsTZD7b7B/kGp1KddN7z
         8XrA==
X-Gm-Message-State: AOAM533ubTrgxbeh6njE3UfVHtmdPWJCesz1oBV1HLrg2V3A4zoSU0VZ
        1KITdYPAF2q25xQc2id1vbYWD+eOgg==
X-Google-Smtp-Source: ABdhPJwnZFshnENIKZHdt1VwC+rvkvsV4+OnqFojG4Rfu94SsahF3CaT2F0GX+ZD5RtE8gVz2NVlZw==
X-Received: by 2002:a4a:e1fb:0:b0:324:6bad:8d1a with SMTP id u27-20020a4ae1fb000000b003246bad8d1amr2722663ood.84.1648154845136;
        Thu, 24 Mar 2022 13:47:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w36-20020a05687033a400b000d75f1d9b82sm1768369oae.47.2022.03.24.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:47:24 -0700 (PDT)
Received: (nullmailer pid 2546966 invoked by uid 1000);
        Thu, 24 Mar 2022 20:47:23 -0000
Date:   Thu, 24 Mar 2022 15:47:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: Add 'slot-power-limit-milliwatt'
 PCIe port property
Message-ID: <YjzY2wUg9SrDzHND@robh.at.kernel.org>
References: <20220302145733.12606-1-pali@kernel.org>
 <20220302145733.12606-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302145733.12606-3-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:57:31PM +0100, Pali Rohár wrote:
> This property specifies slot power limit in mW unit. It is a form-factor
> and board specific value and must be initialized by hardware.
> 
> Some PCIe controllers delegate this work to software to allow hardware
> flexibility and therefore this property basically specifies what should
> host bridge program into PCIe Slot Capabilities registers.
> 
> The property needs to be specified in mW unit instead of the special format
> defined by Slot Capabilities (which encodes scaling factor or different
> unit). Host drivers should convert the value from mW to needed format.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> 
> ---
> This change was already accepted into dt-schema repo by Rob Herring:
> https://github.com/devicetree-org/dt-schema/pull/66

Which is the definitive source for it. pci.txt should shrink or be 
removed, not added to.

> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..b0cc133ed00d 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,12 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- slot-power-limit-milliwatt:
> +   If present, this property specifies slot power limit in milliwatts. Host
> +   drivers can parse this property and use it for programming Root Port or host
> +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> +   through the Root Port or host bridge when transitioning PCIe link from a
> +   non-DL_Up Status to a DL_Up Status.
>  
>  PCI-PCI Bridge properties
>  -------------------------
> -- 
> 2.20.1
> 
