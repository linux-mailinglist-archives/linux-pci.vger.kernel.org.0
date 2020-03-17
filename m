Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C99187ADE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 09:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgCQIMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 04:12:02 -0400
Received: from mail-eopbgr1410118.outbound.protection.outlook.com ([40.107.141.118]:45760
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgCQIMC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 04:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8aukGEkuiWteAk5dmjin9d/0C3J62FE58ssJBqp9XwHvXwWlSPw61n9Brt+t8rskXrIFdT8s7OfGLwxYJyvEBDzG+/WpvCmEeGVVqVfIDcgwvqJKd4Lk09W3f2gpYEjweeakxTd2s9Jpv8Dol7Qr8GEfj9txdzZIg08dM0sutbARWkuzdi3RBHocmou6nsE55jKNLOlYiP7aMmpabx9vkGz2dedlrSwCdt7/lJGbzBX9rKtTALvcj1IWHNTRjXbe5qQLDmhR661vRFmYPknmlvKSlrjY9IxczaA1IUv9CueQZr0VD+fmYlEHym+mChgu/a9AgooGlWsLAXvjQVwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk51RpIV3z65ouhKeErC7AE+u02C5ZqfUsI1ptS+/yM=;
 b=A+74vpEEkuUW8iUbLiGl7fan6wPppMCrayGCN1bDo7bokZud7O9TWGvIEhI1OKhjCiGbGhVBzmlnfXaLApYScIXLWBhA2tzwfXdsEegZapy5wBJaIyndGl8nbl+KqEDVqS6qgy3aN5a4JeOUlWdeYu4joxV/nLosylebBYaK8cnAkf7fDIq+CW70ayDnt0h51nUw/eYWaued+eiahFbL4KVOWqJZDoyjCidLdzzM2OeqitDGmGzoK3AAnbfxXXE2XBrsSDijiqmsAliM9aTJHr6ctXCQeUAcGyaTQ9bSxrjHjM54X7CQ3Ypa+153ZknMXMLrE73yO6/dOKxfdxlSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk51RpIV3z65ouhKeErC7AE+u02C5ZqfUsI1ptS+/yM=;
 b=IOU6eCKGndmWg+zQHjgBMAY6Nx0mHmHyX4sovlllVV6OFVxlO6UaqGj5ezd9eu8GNwjbGZUNix4VJnUoqnYCsm5iWccCJH12yxQooQc8ZqurUy71OPL28k1UPkOw+Azg6kEWtKmUVl/xfwSme/r9wo1YJ7cMMpgacWZxAwKKFk4=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2446.jpnprd01.prod.outlook.com (20.177.104.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 08:11:41 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:11:41 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: RE: [PATCH v5 4/7] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
Thread-Topic: [PATCH v5 4/7] PCI: endpoint: Add support to handle multiple
 base for mapping outbound memory
Thread-Index: AQHV7k2kfqtu6T0o2UCPs98u98LxN6hMgYXQ
Date:   Tue, 17 Mar 2020 08:11:41 +0000
Message-ID: <TYAPR01MB4544599A72C88666B4F972B7D8F60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200228154122.14164-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200228154122.14164-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228154122.14164-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68e53b0c-06b1-4b6e-4644-08d7ca4ad32a
x-ms-traffictypediagnostic: TYAPR01MB2446:|TYAPR01MB2446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB24464B7AF815B5F1BEBA0396D8F60@TYAPR01MB2446.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(6916009)(33656002)(52536014)(55016002)(186003)(7416002)(64756008)(66446008)(9686003)(5660300002)(66556008)(54906003)(66476007)(76116006)(2906002)(4326008)(66946007)(478600001)(81156014)(6506007)(81166006)(316002)(26005)(86362001)(71200400001)(7696005)(8936002)(8676002)(30864003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2446;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hAq/At01g/7tnmlauLsvUd20keMFO+ARPPPTnI/d5FZhj4h4IeACg9yA8jC/K1J1EYfnaCUV0TSpB51gt5rszpNnMQKY5PlUm9OhdLk0PWZ6/JGjLwL2dDU/gAHNfrHXTIDlJNTWeSaOsJZIHDewEOBBtwa5gi31ioxc7qfCqxX3u3cYNpFEaxuTGRMvl7oxmbVyeAgaSTVB9Ki05gdKHpUxcWBNJgIVih9hMF5COoxSwT1bVO2wnnESqtO2Nsm8gcjDw3mBerGAt10I+/rfztrAvcTsFvcTjmAZbFeW8514m48Yi0kcm9xVn4dISmdxs0d8uPDAr3kwZeUk/kd97NCa3QWL3HBCmDbx1c9+PfPJneEf67gPUtGZqOpKDXZ3mzGABtnpmtAiaWoWRC6VI6ujN9WuPS64PL/vbvMo6me5bRgmo4R7mur9JC2V7bhw
x-ms-exchange-antispam-messagedata: LEdjMkMcyFoovUj775K/x/z/smDMvRUScfA2PVS8k/oWWhAqxgy4zzx8xNCFHji2RgdZAoHgGYQ3k6XOSJxSerCN8m/0dX1lYxQ9y3jGWEclfGZPaPn0atpnGRPSUMXapOWBjOjwBvWoWX7683nHMg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e53b0c-06b1-4b6e-4644-08d7ca4ad32a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 08:11:41.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q98jJ9kPMXM04qDhaJcxldY5TQiNSL7ZuB3oDulA+SJvS/TXGnTKb7yCDUZKp1l8lwOpiq21LxAdwgtXOcg6QLrbZuTcm2h6ohs+U0JwxXvq4UEW+8iopOv1NTVbAHjR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2446
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

Thank you for the patch!

> From: Lad Prabhakar, Sent: Saturday, February 29, 2020 12:41 AM
>=20
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires t=
o
> add support for handling multiple memory bases in endpoint framework.
>=20
> With this patch pci_epc_mem_init() now accepts multiple regions, also
> page_size for each memory region is passed during initialization so as
> to handle single allocation for each region by setting the page_size to
> window_size.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c |   7 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c  |  29 ++--
>  drivers/pci/controller/pcie-rockchip-ep.c        |   7 +-
>  drivers/pci/endpoint/pci-epc-mem.c               | 167 ++++++++++++++++-=
------

I could not apply this patch on the latest pci.git / next branch.
So, you need to rebase.

>  include/linux/pci-epc.h                          |  39 ++++--
>  5 files changed, 169 insertions(+), 80 deletions(-)
>=20
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/p=
ci/controller/cadence/pcie-cadence-ep.c
> index 1c173da..90e32438 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -401,6 +401,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	struct device *dev =3D ep->pcie.dev;
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct device_node *np =3D dev->of_node;
> +	struct pci_epc_mem_window mem_window;
>  	struct cdns_pcie *pcie =3D &ep->pcie;
>  	struct resource *res;
>  	struct pci_epc *epc;
> @@ -449,8 +450,10 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
>  		epc->max_functions =3D 1;
>=20
> -	ret =3D pci_epc_mem_init(epc, pcie->mem_res->start,
> -			       resource_size(pcie->mem_res));
> +	mem_window.phys_base =3D pcie->mem_res->start;
> +	mem_window.size =3D resource_size(pcie->mem_res);
> +	mem_window.page_size =3D PAGE_SIZE;
> +	ret =3D pci_epc_mem_init(epc, &mem_window, 1);

I'm not sure my idea is acceptable or not but,
I think we can have compatible API for single window like below.
- In this patch, pci_epc_mem_init() and __pci_epc_mem_init() become the sam=
e behavior.
  So, for example, pci_epc_mem_init() is for simple, and __pci_epc_mem_init=
() is multiple windows.
-- In this case, pci_epc_mem_init() should have page_size argument.
- The original "mem" in the pci_epc can be the default window instead of
  PCI_EPC_DEFAULT_WINDOW.

>  	if (ret < 0) {
>  		dev_err(dev, "failed to initialize the memory space\n");
>  		goto err_init;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index cfeccd7..b150ef3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -195,8 +195,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc=
, u8 func_no,
>  }
>=20
>  static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no,
> -			       phys_addr_t addr,
> -			       u64 pci_addr, size_t size)
> +			       phys_addr_t addr, u64 pci_addr, size_t size)
>  {
>  	int ret;
>  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> @@ -367,6 +366,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u=
8 func_no,
>  	unsigned int aligned_offset;
>  	u16 msg_ctrl, msg_data;
>  	u32 msg_addr_lower, msg_addr_upper, reg;
> +	int window =3D PCI_EPC_DEFAULT_WINDOW;
>  	u64 msg_addr;
>  	bool has_upper;
>  	int ret;
> @@ -390,11 +390,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep,=
 u8 func_no,
>  		reg =3D ep->msi_cap + PCI_MSI_DATA_32;
>  		msg_data =3D dw_pcie_readw_dbi(pci, reg);
>  	}
> -	aligned_offset =3D msg_addr_lower & (epc->mem->page_size - 1);
> +	aligned_offset =3D msg_addr_lower & (epc->mem[window]->page_size - 1);
>  	msg_addr =3D ((u64)msg_addr_upper) << 32 |
>  			(msg_addr_lower & ~aligned_offset);
> -	ret =3D dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->page_size);
> +	ret =3D dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,
> +				  msg_addr, epc->mem[window]->page_size);
>  	if (ret)
>  		return ret;
>=20
> @@ -416,6 +416,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  	u32 reg, msg_data, vec_ctrl;
>  	u64 tbl_addr, msg_addr, reg_u64;
>  	void __iomem *msix_tbl;
> +	int window =3D PCI_EPC_DEFAULT_WINDOW;
>  	int ret;
>=20
>  	reg =3D ep->msix_cap + PCI_MSIX_TABLE;
> @@ -452,8 +453,8 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, =
u8 func_no,
>  		return -EPERM;
>  	}
>=20
> -	ret =3D dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->page_size);
> +	ret =3D dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,
> +				  msg_addr, epc->mem[window]->page_size);
>  	if (ret)
>  		return ret;
>=20
> @@ -466,10 +467,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep=
, u8 func_no,
>=20
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
> +	int window =3D PCI_EPC_DEFAULT_WINDOW;
>  	struct pci_epc *epc =3D ep->epc;
>=20
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> -			      epc->mem->page_size);
> +			      epc->mem[window]->page_size);
>=20
>  	pci_epc_mem_exit(epc);
>  }
> @@ -502,6 +504,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	unsigned int nbars;
>  	unsigned int offset;
>  	struct pci_epc *epc;
> +	size_t msi_page_size;
> +	struct pci_epc_mem_window mem_window;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	struct device *dev =3D pci->dev;
>  	struct device_node *np =3D dev->of_node;
> @@ -574,15 +578,18 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ret < 0)
>  		epc->max_functions =3D 1;
>=20
> -	ret =3D __pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> -				 ep->page_size);
> +	mem_window.phys_base =3D ep->phys_base;
> +	mem_window.size =3D ep->addr_size;
> +	mem_window.page_size =3D ep->page_size;
> +	ret =3D __pci_epc_mem_init(epc, &mem_window, 1);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to initialize address space\n");
>  		return ret;
>  	}
>=20
> +	msi_page_size =3D epc->mem[PCI_EPC_DEFAULT_WINDOW]->page_size;
>  	ep->msi_mem =3D pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> -					     epc->mem->page_size);
> +					     msi_page_size);
>  	if (!ep->msi_mem) {
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>  		return -ENOMEM;
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/cont=
roller/pcie-rockchip-ep.c
> index d743b0a..5a97390 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -562,6 +562,7 @@ static const struct of_device_id rockchip_pcie_ep_of_=
match[] =3D {
>=20
>  static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  {
> +	struct pci_epc_mem_window mem_window;
>  	struct device *dev =3D &pdev->dev;
>  	struct rockchip_pcie_ep *ep;
>  	struct rockchip_pcie *rockchip;
> @@ -614,8 +615,10 @@ static int rockchip_pcie_ep_probe(struct platform_de=
vice *pdev)
>  	/* Only enable function 0 by default */
>  	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
>=20
> -	err =3D pci_epc_mem_init(epc, rockchip->mem_res->start,
> -			       resource_size(rockchip->mem_res));
> +	mem_window.phys_base =3D rockchip->mem_res->start;
> +	mem_window.size =3D resource_size(rockchip->mem_res);
> +	mem_window.page_size =3D PAGE_SIZE;
> +	err =3D pci_epc_mem_init(epc, &mem_window, 1);
>  	if (err < 0) {
>  		dev_err(dev, "failed to initialize the memory space\n");
>  		goto err_uninit_port;
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pc=
i-epc-mem.c
> index d2b174c..6c21957 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -38,57 +38,76 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *=
mem, size_t size)
>  /**
>   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_init
> - * @phys_base: the physical address of the base
> - * @size: the size of the address space
> - * @page_size: size of each page
> + * @windows: pointer to windows supported by the device
> + * @num_windows: number of windows device supports
>   *
>   * Invoke to initialize the pci_epc_mem structure used by the
>   * endpoint functions to allocate mapped PCI address.
>   */
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_=
t size,
> -		       size_t page_size)
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *w=
indows,
> +		       int num_windows)
>  {
> -	int ret;
> -	struct pci_epc_mem *mem;
> -	unsigned long *bitmap;
> +	struct pci_epc_mem *mem =3D NULL;
> +	unsigned long *bitmap =3D NULL;
>  	unsigned int page_shift;
> -	int pages;
> +	size_t page_size;
>  	int bitmap_size;
> -
> -	if (page_size < PAGE_SIZE)
> -		page_size =3D PAGE_SIZE;
> -
> -	page_shift =3D ilog2(page_size);
> -	pages =3D size >> page_shift;
> -	bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> -
> -	mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> -	if (!mem) {
> -		ret =3D -ENOMEM;
> -		goto err;
> -	}
> -
> -	bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> -	if (!bitmap) {
> -		ret =3D -ENOMEM;
> -		goto err_mem;
> +	int pages;
> +	int ret;
> +	int i;
> +
> +	epc->mem_windows =3D 0;
> +
> +	if (!windows)
> +		return -EINVAL;
> +
> +	if (num_windows <=3D 0)
> +		return -EINVAL;
> +
> +	epc->mem =3D kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> +	if (!epc->mem)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_windows; i++) {
> +		page_size =3D windows[i].page_size;
> +		if (page_size < PAGE_SIZE)
> +			page_size =3D PAGE_SIZE;
> +		page_shift =3D ilog2(page_size);
> +		pages =3D windows[i].size >> page_shift;
> +		bitmap_size =3D BITS_TO_LONGS(pages) * sizeof(long);
> +
> +		mem =3D kzalloc(sizeof(*mem), GFP_KERNEL);
> +		if (!mem) {
> +			ret =3D -ENOMEM;
> +			goto err_mem;
> +		}
> +
> +		bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> +		if (!bitmap) {
> +			ret =3D -ENOMEM;
> +			goto err_mem;
> +		}
> +
> +		mem->bitmap =3D bitmap;
> +		mem->window.phys_base =3D windows[i].phys_base;

I could not understand why the window member is needed.
I think original members (just phys_base and size) are enough.
Also, this function doesn't store the page_size to mem->window.page_size.

> +		mem->page_size =3D page_size;
> +		mem->pages =3D pages;
> +		mem->window.size =3D windows[i].size;
> +		epc->mem[i] =3D mem;
>  	}
> -
> -	mem->bitmap =3D bitmap;
> -	mem->phys_base =3D phys_base;
> -	mem->page_size =3D page_size;
> -	mem->pages =3D pages;
> -	mem->size =3D size;
> -
> -	epc->mem =3D mem;
> +	epc->mem_windows =3D num_windows;
>=20
>  	return 0;
>=20
>  err_mem:
> -	kfree(mem);
> +	for (; i >=3D 0; i--) {
> +		mem =3D epc->mem[i];
> +		kfree(mem->bitmap);

If bitmap cannot be allocated, the epc->mem[i] is NULL.
So, freeing mem->bitmap anyway is not good.

> +		kfree(mem);
> +	}
> +	kfree(epc->mem);
>=20
> -err:
> -return ret;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>=20
> @@ -101,11 +120,21 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>   */
>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -	struct pci_epc_mem *mem =3D epc->mem;
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	if (!epc->mem_windows)
> +		return;
> +
> +	for (i =3D 0; i <=3D epc->mem_windows; i++) {
> +		mem =3D epc->mem[i];
> +		kfree(mem->bitmap);
> +		kfree(mem);
> +	}
> +	kfree(epc->mem);
>=20
>  	epc->mem =3D NULL;
> -	kfree(mem->bitmap);
> -	kfree(mem);
> +	epc->mem_windows =3D 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>=20
> @@ -121,20 +150,30 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	int pageno;
> -	void __iomem *virt_addr;
> -	struct pci_epc_mem *mem =3D epc->mem;
> -	unsigned int page_shift =3D ilog2(mem->page_size);
> +	void __iomem *virt_addr =3D NULL;
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	int pageno =3D -EINVAL;
>  	int order;
> +	int i;
>=20
> -	size =3D ALIGN(size, mem->page_size);
> -	order =3D pci_epc_mem_get_order(mem, size);
> +	for (i =3D 0; i < epc->mem_windows; i++) {
> +		mem =3D epc->mem[i];
> +		size =3D ALIGN(size, mem->page_size);
> +		order =3D pci_epc_mem_get_order(mem, size);
> +
> +		pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages,
> +						 order);
> +		if (pageno >=3D 0)
> +			break;
> +	}
>=20
> -	pageno =3D bitmap_find_free_region(mem->bitmap, mem->pages, order);
>  	if (pageno < 0)
>  		return NULL;
>=20
> -	*phys_addr =3D mem->phys_base + ((phys_addr_t)pageno << page_shift);
> +	page_shift =3D ilog2(mem->page_size);
> +	*phys_addr =3D mem->window.phys_base +
> +		     ((phys_addr_t)pageno << page_shift);
>  	virt_addr =3D ioremap(*phys_addr, size);
>  	if (!virt_addr)
>  		bitmap_release_region(mem->bitmap, pageno, order);
> @@ -143,6 +182,23 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc =
*epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>=20
> +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> +						phys_addr_t phys_addr)
> +{
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	for (i =3D 0; i < epc->mem_windows; i++) {
> +		mem =3D epc->mem[i];
> +
> +		if (phys_addr >=3D mem->window.phys_base &&
> +		    phys_addr < (mem->window.phys_base + mem->window.size))
> +			return mem;
> +	}
> +
> +	return NULL;
> +}
> +
>  /**
>   * pci_epc_mem_free_addr() - free the allocated memory address
>   * @epc: the EPC device on which memory was allocated
> @@ -155,13 +211,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size)
>  {
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
>  	int pageno;
> -	struct pci_epc_mem *mem =3D epc->mem;
> -	unsigned int page_shift =3D ilog2(mem->page_size);
>  	int order;
>=20
> +	mem =3D pci_epc_get_matching_window(epc, phys_addr);
> +	if (!mem) {
> +		pr_err("failed to get matching window\n");
> +		return;
> +	}
> +
> +	page_shift =3D ilog2(mem->page_size);
>  	iounmap(virt_addr);
> -	pageno =3D (phys_addr - mem->phys_base) >> page_shift;
> +	pageno =3D (phys_addr - mem->window.phys_base) >> page_shift;
>  	size =3D ALIGN(size, mem->page_size);
>  	order =3D pci_epc_mem_get_order(mem, size);
>  	bitmap_release_region(mem->bitmap, pageno, order);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 56f1846..dde42e5 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -64,17 +64,29 @@ struct pci_epc_ops {
>  	struct module *owner;
>  };
>=20
> +#define PCI_EPC_DEFAULT_WINDOW         0
> +
> +/**
> + * struct pci_epc_mem_window - address window of the endpoint controller
> + * @phys_base: physical base address of the PCI address window
> + * @size: the size of the PCI address window
> + * @page_size: size of each page
> + */
> +struct pci_epc_mem_window {
> +	phys_addr_t	phys_base;
> +	size_t		size;
> +	size_t		page_size;
> +};
> +
>  /**
>   * struct pci_epc_mem - address space of the endpoint controller
> - * @phys_base: physical base address of the PCI address space
> - * @size: the size of the PCI address space
> + * @window: address window of the endpoint controller
>   * @bitmap: bitmap to manage the PCI address space
> - * @pages: number of bits representing the address region
>   * @page_size: size of each page
> + * @pages: number of bits representing the address region
>   */
>  struct pci_epc_mem {
> -	phys_addr_t	phys_base;
> -	size_t		size;
> +	struct pci_epc_mem_window window;
>  	unsigned long	*bitmap;
>  	size_t		page_size;
>  	int		pages;
> @@ -85,7 +97,8 @@ struct pci_epc_mem {
>   * @dev: PCI EPC device
>   * @pci_epf: list of endpoint functions present in this EPC device
>   * @ops: function pointers for performing endpoint operations
> - * @mem: address space of the endpoint controller

If my idea is acceptable, this should be "default address space ...".

> + * @mem: array of address space of the endpoint controller

And, this should be difference name.

> + * @mem_windows: number of windows supported by device

Perhaps, num_windows?

>   * @max_functions: max number of functions that can be configured in thi=
s EPC
>   * @group: configfs group representing the PCI EPC device
>   * @lock: spinlock to protect pci_epc ops
> @@ -94,7 +107,8 @@ struct pci_epc {
>  	struct device			dev;
>  	struct list_head		pci_epf;
>  	const struct pci_epc_ops	*ops;
> -	struct pci_epc_mem		*mem;
> +	struct pci_epc_mem		**mem;
> +	unsigned int			mem_windows;
>  	u8				max_functions;
>  	struct config_group		*group;
>  	/* spinlock to protect against concurrent access of EP controller */
> @@ -128,8 +142,8 @@ struct pci_epc_features {
>  #define devm_pci_epc_create(dev, ops)    \
>  		__devm_pci_epc_create((dev), (ops), THIS_MODULE)
>=20
> -#define pci_epc_mem_init(epc, phys_addr, size)	\
> -		__pci_epc_mem_init((epc), (phys_addr), (size), PAGE_SIZE)
> +#define pci_epc_mem_init(epc, windows, num_windows)	\
> +		__pci_epc_mem_init((epc), windows, num_windows)

As I mentioned above, pci_epc_mem_init() and __ pci_epc_mem_init() are the =
same behavior.

>  static inline void epc_set_drvdata(struct pci_epc *epc, void *data)
>  {
> @@ -159,8 +173,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>  		       struct pci_epf_bar *epf_bar);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> -		     phys_addr_t phys_addr,
> -		     u64 pci_addr, size_t size);
> +		     phys_addr_t phys_addr, u64 pci_addr, size_t size);

Perhaps, this is not needed to change?

Best regards,
Yoshihiro Shimoda

>  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>  			phys_addr_t phys_addr);
>  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 interrupts);
> @@ -178,8 +191,8 @@ unsigned int pci_epc_get_first_free_bar(const struct =
pci_epc_features
>  struct pci_epc *pci_epc_get(const char *epc_name);
>  void pci_epc_put(struct pci_epc *epc);
>=20
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_=
t size,
> -		       size_t page_size);
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *w=
indow,
> +		       int num_windows);
>  void pci_epc_mem_exit(struct pci_epc *epc);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size);
> --
> 2.7.4

