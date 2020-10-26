Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE22C29923A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775606AbgJZQWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 12:22:31 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40927 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773147AbgJZQWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 12:22:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id l2so3335276pjt.5
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=VldKDaJrZxVwG4A16mywFY5rzmy8QYlD+uVPC/uSv3I=;
        b=i4sOXquFjNzRHwiII1a8xHlL+6a3I0Q0o5OCjidQVmXQpzIG7QnmfTtom/tyNu6tLC
         firuLgwROT6a//ybnZod8FyPV59otxZNFvkcMrVWJ3tAuoDqkVA5yEoIA7qN4nadxUkI
         HFuct7011G1EXsCd/JLiPWuSlAPkhhvtrqN1YKyIVpdyuooh/0PL04pvp7SU07V5ev7c
         e+jeMvsnQCKylVsJiCoIaMEihHA9vFlsb52wXMFyvV2+AmJAdKM48aomGJyykSEQMDNe
         fnEaWc+mxOPjkcUjAhiZvTrasoLjmD+mLRQXnv1Ms+ePmlJgv+NRxgvNdhe2kM00ReA6
         BYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=VldKDaJrZxVwG4A16mywFY5rzmy8QYlD+uVPC/uSv3I=;
        b=Z+dRUSq2hA6VvAK1yo6jHUxMu+3SQz53HQbp5Vw03/lu0vwFGw96iy2iH4OYOy/N0p
         DcXp3+L5ViRn84K7PDZf7ys0ydOS1mcMIcJziVULV4ijXq4F25Pk1mfWxsNqsaQQYn9Y
         RrVqCcw43LBI9gAtSjewhquQzZAD2dRuQRAFkBKK8Xpq+cZf1bMAVuDwmeaRbv73oE3k
         ZvQ9USuApDuqY8lMjjdFMdp9qIUU5+Fh53o/NMTQTOsFjq9+Nz6y4KucIlWosqQ6ee6a
         x4Bn8PnanzSCSeeeF6cesbTCIaLZR1GURRkNjfSTkU/CgjXkfQTDiLMhUf4J8WBYz6kJ
         XYjg==
X-Gm-Message-State: AOAM531g08iOFldHVbajNy5rmmoN+aULTsEeyjeQUk0ESxMGIeRMio6k
        4PKaag2fLdVcKrQ1cvcVYo0=
X-Google-Smtp-Source: ABdhPJyvx7AwATmMcyZ7PW+9R/u+tlyQ89rGXTetquftgcAmH7AXpcWpQL9tkqHY0mXWkcu75jID1Q==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr16746198pjz.73.1603729350190;
        Mon, 26 Oct 2020 09:22:30 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id b16sm12384911pfp.195.2020.10.26.09.22.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:22:29 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last
 entry
Thread-Topic: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last
 entry
Thread-Index: AWgxMTU2XEXh5hQMo5zSj8VhjgsGadz1BfST
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 26 Oct 2020 16:22:25 +0000
Message-ID: <SLXP216MB0477EED7E80B8738CCD233E7AA190@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201026154852.221483-1-robh@kernel.org>
In-Reply-To: <20201026154852.221483-1-robh@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/20, 11:48 AM, Rob Herring wrote:
>=20
> Prior to commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI
> resources"), the DWC driver was setting up the last memory resource
> rather than the first memory resource. This doesn't matter for most
> platforms which only have 1 memory resource, but it broke Tegra194 which
> has a 2nd (prefetchable) memory region which requires an ATU entry. The
> first region on Tegra194 relies on the default 1:1 pass-thru of outbound
> transactions which doesn't need an ATU entry.
>
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Reported-by: Vidya Sagar <vidyas@nvidia.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 674f32db85ca..44c2a6572199 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -586,8 +586,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	 * ATU, so we should not program the ATU here.
>  	 */
>  	if (pp->bridge->child_ops =3D=3D &dw_child_pcie_ops) {
> -		struct resource_entry *entry =3D
> -			resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +		struct resource_entry *tmp, *entry =3D NULL;
> +
> +		/* Get last memory resource entry */
> +		resource_list_for_each_entry(tmp, &pp->bridge->windows)
> +			if (resource_type(tmp->res) =3D=3D IORESOURCE_MEM)
> +				entry =3D tmp;
>
>  		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>  					  PCIE_ATU_TYPE_MEM, entry->res->start,
> --=20
> 2.25.1

