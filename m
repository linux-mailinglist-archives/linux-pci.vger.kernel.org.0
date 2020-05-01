Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90501C196E
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgEAPZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 11:25:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39391C061A0C;
        Fri,  1 May 2020 08:25:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so4691356pgo.3;
        Fri, 01 May 2020 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=dAeSZvNZMQXDqJlUqtS3Ql4DBa9037cFjMUtWfOB8LY=;
        b=bU9qHVx0wOmVaH0gDZL/CnxJRT9/wID9QouT+BfYlH1sq4r/36z6qlaZS9zt4HMzaq
         bImUyhsmyviLEyNpToB2N9bRtVkvKeFxbw4w/9q08DUkwrbMRg1FCWhWrQJB/UL/jNdV
         ZeHfFb3lK1G5RgeMVeeTBMQ7XOLSHrnzGXWgNd2qHzaKy92XEQsfgbjZ9SC2PQ+QXTZ5
         4u/aLhZA5tmYohVQkBxjq4HrBEbYggLmubZZkDp0yWdqw9+XqQfpu2YetvLfKG+0DGBn
         AGbgsK4EUrqwMJMojTjRvucuqKtyXh5iV+4BGnGX3zvfYPpFVZtNA0eSQOyURwd0FCq3
         iPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=dAeSZvNZMQXDqJlUqtS3Ql4DBa9037cFjMUtWfOB8LY=;
        b=NtkuwP3xUrO3C4AEioDgWlcADA2rJKrOQ1nupBF5d2dUDZnsFgvKWjpITn8dkLwa4H
         P2K4ckuXwQaNBaE/bPvLD1UcdfyfTkhPhv0yAO0AP6ZGdL3MUG4bbs5JqC90SUU74+bh
         D6Ob4SW96Y0+orE+96MbxzsMgMCEz3HPI1xCSd/II5hnpYS6XxicHVwnMCAuRHHH8j8D
         vLuvNKYWhNaXYhr+4gRDVoNkwOhOYZMImpz/J8oHRmmzUxRWrXTufBE0H1U8/MZIpa2t
         guiZ/T2iiIyq/CA8sQea2E9hfPG6JUlTKhWKXYDotRB17Wp5GpVB02lk7jY/dXohUqqh
         wScA==
X-Gm-Message-State: AGi0PuaTyVG2DvF90p+hIQLRg2z75LPi3MtS17G3nh4OsVdeo8vg68uM
        WxzITIsfb4/rJ1dMNBiomcE=
X-Google-Smtp-Source: APiQypJ3ooMOdWJHnDylgqEuIXANhYHe9A29Vf38JrKTGlpb0/WPJyP+gYgiiBVuf/k/KrCdTGnOQQ==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr4567105pfc.190.1588346723341;
        Fri, 01 May 2020 08:25:23 -0700 (PDT)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id q11sm2528147pfl.97.2020.05.01.08.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 08:25:22 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: dwc: Fix inner MSI IRQ domain registration
Thread-Topic: [PATCH] PCI: dwc: Fix inner MSI IRQ domain registration
Thread-Index: AXotNjkw5GEX6TEnWRYx1vOqydMHfLflLPuG
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Fri, 1 May 2020 15:25:17 +0000
Message-ID: <SL2P216MB0105440F639E502B31DE6A42AAAB0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20200501113921.366597-1-maz@kernel.org>
In-Reply-To: <20200501113921.366597-1-maz@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/1/20, 7:39 AM, Marc Zyngier wrote:
> On a system that uses the internal DWC MSI widget, I get this
> warning from debugfs when CONFIG_GENERIC_IRQ_DEBUGFS is selected:
>
>   debugfs: File ':soc:pcie@fc000000' in directory 'domains' already prese=
nt!
>
> This is due to the fact that the DWC MSI code tries to register two
> IRQ domains for the same firmware node, without telling the low
> level code how to distinguish them (by setting a bus token). This
> further confuses debugfs which tries to create corresponding
> files for each domain.
>
> Fix it by tagging the inner domain as DOMAIN_BUS_NEXUS, which is
> the closest thing we have as to "generic MSI".
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>


> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 395feb8ca051..3c43311bb95c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -264,6 +264,8 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  		return -ENOMEM;
>  	}
> =20
> +	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
> +
>  	pp->msi_domain =3D pci_msi_create_irq_domain(fwnode,
>  						   &dw_pcie_msi_domain_info,
>  						   pp->irq_domain);
> --=20
> 2.26.2

