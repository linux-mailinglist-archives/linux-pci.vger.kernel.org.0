Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB13844E9FA
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbhKLP2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 10:28:13 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38907 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhKLP2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 10:28:12 -0500
Received: by mail-ot1-f49.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so14338205otj.5;
        Fri, 12 Nov 2021 07:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RVXOKUzn8xx+A/BupGQH+H1y0lrA5OuyDafvitY6wbw=;
        b=Ll51/pVEjb+3sDEQFQ2vOq+UoWIPAA31G3QEMQT8gWASmOmWjTaluDoW3H5dgoGCKQ
         ifKaShLKNFRRBY4bS7PtPTjsrmxAjSd+PwBvkxgJdLxd+52Fl8ZG7+X67ATMSRBS+/Hv
         ec1LogTN5MQS4RM4WNMq7EtqcUgKixs7j8wlgUVzvGhjc/Nxxx2Y3nRKUey89JBwXUSW
         /YbQKYQdPLTCVAFjRnalIIl02Bn3NOiQzhsccwPudI++0dxfr8QyBBosTm0SGfMVbFuJ
         d4Vzl1aLmBEQaewuLTN0f4jn6kYIyg3PHXJVivFcKWkYQdMj8HKv5GW8eoK1xT5zBgPN
         ExbA==
X-Gm-Message-State: AOAM532G2JzHBzS9GHDTyHXx9sjFIcu8BNALvKf6lvtTv/2+E8WgUcbx
        b/bSbsV9At/fG9nu9fDpYRctulVLFg==
X-Google-Smtp-Source: ABdhPJxu33SV5+1/0Na2x6ygvkBdQx6MbCAqUgjHERfuNpjoS46LGDUC7vbjn4IQa/e2YId3CgF5YA==
X-Received: by 2002:a9d:6653:: with SMTP id q19mr13101255otm.116.1636730721655;
        Fri, 12 Nov 2021 07:25:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l2sm1260686otl.61.2021.11.12.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:25:20 -0800 (PST)
Received: (nullmailer pid 2878900 invoked by uid 1000);
        Fri, 12 Nov 2021 15:25:20 -0000
Date:   Fri, 12 Nov 2021 09:25:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <YY6HYM4T+A+tm85P@robh.at.kernel.org>
References: <20211031150706.27873-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211031150706.27873-1-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
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
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..7296d599c5ac 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,12 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- slot-power-limit-miliwatt:

Typo.

But we shouldn't be adding to pci.txt. This needs to go in the 
schema[1]. Patch to devicetree-spec list or GH PR is fine.

> +   If present, this property specifies slot power limit in milliwatts. Host
> +   drivers can parse this property and use it for programming Root Port or host
> +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> +   through the Root Port or host bridge when transitioning PCIe link from a
> +   non-DL_Up Status to a DL_Up Status.

If your slots are behind a switch, then doesn't this apply to any bridge 
port?

[1] https://github.com/devicetree-org/dt-schema/blob/main/schemas/pci/pci-bus.yaml
