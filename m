Return-Path: <linux-pci+bounces-988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C3812CA3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484E41F21918
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE239FF7;
	Thu, 14 Dec 2023 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMPPUwlQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29C114
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:15:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d04dba2781so47761535ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702548926; x=1703153726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUdVNRKMX4Cx5Orml+0GGoXetMeFfZaZP2784m2QjJ4=;
        b=PMPPUwlQeWlfUbRz2K+1wkZ3Zs+JvLCb26+QR59t0S8IrTd0GyONhnepM4rnPNlmWl
         Kz9mp39PgMYQYOprDf757gj0rP6Y+l8JqdhZHYVhTnUQvq5HTYlMVKPE7PQEg18Gq+HD
         ZSIGq6WSUJrXy+frw1r/OuNEP13GvktYJbcSsETuB7utd7SgaBtu2geXn3Id3IcHHRqc
         rch2RQGbWoNQwosB3zyiEDrHn3T8lziY6/rBs8QqmnRYwaLl4CZ2d6mz+I+Gta6R9U9v
         c2GFEuIhqGllUe5MvgpmBEqLvTcMhqdNLiigkLgg6hHJ8EhhhZly0VVyIJ5uetc9XjAP
         munQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548926; x=1703153726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUdVNRKMX4Cx5Orml+0GGoXetMeFfZaZP2784m2QjJ4=;
        b=X2drdAOob8Y1Ul31J4BAfwof4kNqkaNw8DcEdNy8EX+lmOuZmZGugMzBOYtn+hk6yj
         B0TT0rUFObWP9lGaES3mKcMnW8sWeUL8Z/jq54MVc/dIy2Pit+DXZNteeZKJ7S39BOyR
         LUZmbsmSOiZvfqJ4oL8TpvgSXuwaQZvVAy0Ya2BwGlcGsk9hsllINr6iLAopS/qxoAV8
         PcY/qfW1eXUNEWxqhSSN52B0dTBsGwLT2djV4QKIGQHhGqmxSnX7VZPRIg0SkY8UU6uj
         hIDO5u0kjfG/r0pL17O7C+k/0OOvUye9CxOJrzXLW0dM3erprmco5ucIOJfTW3GWMA7i
         i5jQ==
X-Gm-Message-State: AOJu0YxnOEiuVPMUfMTVjGHWv1prBsjGaRRVemZ50Dfpruo8NIHC4M0w
	DSdRw9y+e0FRjZEkAteU5nrl
X-Google-Smtp-Source: AGHT+IEovuy1aE+8Oh/ICFTdKuB0NyJInHclalxlNsccsdsIXh79KDlB83JKOkxWhBCa3uZLlvK51A==
X-Received: by 2002:a17:902:6e02:b0:1d3:2e0d:cd98 with SMTP id u2-20020a1709026e0200b001d32e0dcd98mr3152463plk.105.1702548925560;
        Thu, 14 Dec 2023 02:15:25 -0800 (PST)
Received: from thinkpad ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b001d0c37a9cdesm11989727plg.38.2023.12.14.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:15:25 -0800 (PST)
Date: Thu, 14 Dec 2023 15:45:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
Message-ID: <20231214101515.GJ2938@thinkpad>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231214051328.GD2938@thinkpad>
 <AS8PR04MB84046143C236AEA322BBBAD3928CA@AS8PR04MB8404.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB84046143C236AEA322BBBAD3928CA@AS8PR04MB8404.eurprd04.prod.outlook.com>

On Thu, Dec 14, 2023 at 10:03:51AM +0000, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2023年12月14日 13:13
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> > imx@nxp.com>; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
> >
> > On Wed, Dec 13, 2023 at 05:28:46PM +0800, Sherry Sun wrote:
> > > Add pci host wakeup feature for imx platforms. The host wake pin is a
> > > standard feature in the PCIe bus specification, so we can add this
> > > property under PCI dts node to support the host gpio wakeup feature.
> > >
> > > Example of configuring the corresponding dts property under the PCI node:
> > >     wake-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;
> > >
> >
> > As you mentioned, WAKE# is a standard sideband signal defined in the PCI
> > spec.
> > So the support for handling it has to be in the PCI core layer, not in the host
> > controller drivers.
> >
> > There is already a series floating to add support for WAKE# in PCI core.
> > Please take a look:
> >
> > https://lore.k/
> > ernel.org%2Flinux-pci%2F20230208111645.3863534-1-
> > mmaddireddy%40nvidia.com%2F&data=05%7C02%7Csherry.sun%40nxp.co
> > m%7C0254c001df61498c09d408dbfc636f5c%7C686ea1d3bc2b4c6fa92cd99c5
> > c301635%7C0%7C0%7C638381276239824912%7CUnknown%7CTWFpbGZsb3
> > d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D%7C3000%7C%7C%7C&sdata=IoBAwTy0qeb0J6JrK0WRhI8A4ThUfkVx6mri
> > ve%2BK5xs%3D&reserved=0
> 
> Hi Manivannan,
> I checked the patch set, the implementation of host wake gpio is different from mine, I referred to the mmc bus cd(card detect) pin implementation and I think it is simpler and clearer.

It's not just about simple and clear code, but about scalability. See below.

> Regarding whether the WAKE# support should be moved to PCI core layer, we may need more research and discussion. Thanks for your suggestions.
> 

We can research and come up with a better solution, but the implementation has
to be done in the PCI core layer. Otherwise, host controllers supporting WAKE#
has to duplicate the code which is common.

- Mani

> Best Regards
> Sherry
> 
> 
> >
> > - Mani
> >
> > > ---
> > > changes in V2:
> > > 1. Rename host-wake-gpio property to wake-gpios.
> > > 2. Improve the wake-gpios property description in the dt-binding doc
> > > to avoid confusion.
> > > 3. Remove unnecessary debugging info in host_wake_irq_handler().
> > > 4. Remove unnecessary imx6_pcie->host_wake_irq = -1 resetting in error
> > paths.
> > > 5. Use dev_err_probe() to simplify error path code.
> > > ---
> > >
> > > Sherry Sun (4):
> > >   PCI: imx6: Add pci host wakeup support on imx platforms.
> > >   dt-bindings: imx6q-pcie: Add wake-gpios property
> > >   arm64: dts: imx8mp-evk: add wake-gpios property for pci bus
> > >   arm64: dts: imx8mq-evk: add wake-gpios property for pci bus
> > >
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml          |  6 ++
> > >  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |  2 +
> > > arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +
> > >  drivers/pci/controller/dwc/pci-imx6.c         | 60 +++++++++++++++++++
> > >  4 files changed, 70 insertions(+)
> > >
> > > --
> > > 2.34.1
> > >
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

