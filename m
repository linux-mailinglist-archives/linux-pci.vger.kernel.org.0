Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF13F61C3
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhHXPgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 11:36:21 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:39696 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhHXPgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 11:36:21 -0400
Received: by mail-ot1-f54.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so47118976otf.6;
        Tue, 24 Aug 2021 08:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jINYQ1mvHiE2zLCibJDthuXZKNa+sewnEyR+eVgyDUc=;
        b=gzTjIUzx6SbNm74FsVAs3TDLsgYjLmn9zecn8xWSg8FHXEgXrJ9+IUsoswBn4xBP/m
         fkd6W4a2GSTLxfSGaQvz8jiKTkrbHd60oGWvOZ5E7NedVAjGT//xKqnjD1Hela7WJn7k
         qoka7CRFkUiPy0kB/tbXo2zo0jQoQmnhrFUgL6aaBx2mu5jR+TFD6kvwiV21ettcexHB
         OD8PA4Ys7Qq6zcNj1zqRsdk6P2FaoumKhTmop0FjAJ6MCKAfYUibX6x02PY8u0k/d3TA
         tIKl6ZDhCObwb+H7SSZ8tQexlAPbgcVnobgJxTBM/ETUXzrLMlAkcz0V6JGmV1d3pmRL
         TYSA==
X-Gm-Message-State: AOAM530HW3rFIlMMcdBSUsfuFPuYp9QYMHZtXvtVp1ZM1bgxQBdO2mhx
        5MlpjeBfDcsZpb9nVoj6Kg==
X-Google-Smtp-Source: ABdhPJwro+5pXYcQli7tWFYc7LyPVh7C9bSuXsvUSn+YdFxxcHSAJ6CXP/U5QuZPqO6bL9O1ZEre6A==
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr11429689otu.16.1629819336616;
        Tue, 24 Aug 2021 08:35:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l16sm4589113ota.55.2021.08.24.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:35:35 -0700 (PDT)
Received: (nullmailer pid 496698 invoked by uid 1000);
        Tue, 24 Aug 2021 15:35:34 -0000
Date:   Tue, 24 Aug 2021 10:35:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add 'slot-power-limit' PCIe port
 property
Message-ID: <YSURxtc7UAaSEfSy@robh.at.kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
 <20210820160023.3243-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820160023.3243-2-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 20, 2021 at 06:00:21PM +0200, Pali Rohár wrote:
> This property specifies slot power limit in mW unit. It is form-factor and
> board specific value and must be initialized by hardware.
> 
> Some PCIe controllers delegates this work to software to allow hardware
> flexibility and therefore this property basically specifies what should
> host bridge programs into PCIe Slot Capabilities registers.
> 
> Property needs to be specified in mW unit, and not in special format
> defined by Slot Capabilities (which encodes scaling factor or different
> unit). Host drivers should convert value from mW unit to their format.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

This needs to be in dtschema schemas/pci/pci-bus.yaml instead.

(pci.txt is still here because it needs to be relicensed to move all the 
descriptions to pci-bus.yaml.)

> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..e67d5db21514 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -32,6 +32,12 @@ driver implementation may support the following properties:
>     root port to downstream device and host bridge drivers can do programming
>     which depends on CLKREQ signal existence. For example, programming root port
>     not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> +- slot-power-limit:
> +   If present this property specifies slot power limit in mW unit. Host drivers

As mentioned, this should have a unit suffix. I'm not sure it is 
beneficial to share with SFP in this case though.

> +   can parse this slot power limit and use it for programming Root Port or host
> +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit message
> +   through the Root Port or host bridge when transitioning PCIe link from a
> +   non-DL_Up Status to a DL_Up Status.

I no nothing about how this mechanism works, but I think this belongs in 
the next section as for PCIe, a slot is always below a PCI-PCI bridge. 
If we have N slots, then there's N bridges and needs to be N 
slot-power-limit properties, right?

(The same is probably true for all the properties here except 
linux,pci-domain.) There's no distinction between host and PCI bridges  
in pci-bus.yaml though.

Rob
