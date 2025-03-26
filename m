Return-Path: <linux-pci+bounces-24758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB00A715B9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CF53BF411
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078F1C8635;
	Wed, 26 Mar 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H/Gsgbhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34F1BE871
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988428; cv=none; b=dipUSEe5TY41VnYe8yod1tVpvD6Q75vEMcgkZEJOJcEkbx9BbNJWP1yMM+onpLwgP/fvNSxi8RgC21KWuHor+NKS08FnJGoh4vn0FnuwKT3CA/qaainJ6Yj7+oOht0ElixoUAmI0uf2XvicSeAIbmFEujOedjGwpvqZvL9q84kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988428; c=relaxed/simple;
	bh=mW/Q9nIU0kp8tDCh+6U2GwhNo9XqlHJ6PigaoBmWwcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=icEtwU9uD8ndfr/fwCZ+8GP7RDZyJgTvb02HJAGQoYTL+3O1MP9wF8+4BDMu/ZigrqycLhTe3Tqza1TDYMoVPSTviSYqlSROFOAFQRTvylfhwPCLuUC0aDcKWOyYpx0LAbRPK0qs3BOv6PE8CWi06iEFkHyhPpVlup3vDVJzOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H/Gsgbhh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250326112658euoutp010bcce13c79245e2d8cf8e0c27e9ffa57~wVrtT022d0642806428euoutp01C
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 11:26:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250326112658euoutp010bcce13c79245e2d8cf8e0c27e9ffa57~wVrtT022d0642806428euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742988418;
	bh=JNzUkgewJxVw+djbfV7Om+X3X2br3UJlxB3aD3WIpL4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=H/Gsgbhh52kAkAWU1ySSVLdyYXoZgdzsmqF40i09jQZEwz60rYhR1kyuNqz/Pg2D5
	 0gPtMRNvonNd1jn22H/zqS+z7qcX1AEgyoebJQiQpTJeayGkUnfVa4ocSicGAzaJ/3
	 G2h5OruCWuxJbnj3czNDlF3hvtt+FNSMX+WOcc1I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250326112656eucas1p193066b529e16ef428bd680dabf570841~wVrr7tGkI0973109731eucas1p1N;
	Wed, 26 Mar 2025 11:26:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.35.20397.084E3E76; Wed, 26
	Mar 2025 11:26:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250326112656eucas1p27c3b714ecf38ca2249c5aa1261ed3f7e~wVrrUROrM0050000500eucas1p2X;
	Wed, 26 Mar 2025 11:26:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250326112656eusmtrp1c89addaa1a2d2f471d76f305d45578c9~wVrrTlktV2343023430eusmtrp1C;
	Wed, 26 Mar 2025 11:26:56 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-ca-67e3e48044ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.CD.19654.084E3E76; Wed, 26
	Mar 2025 11:26:56 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250326112654eusmtip17f1c64d1e828f29e834b0004a1496fd7~wVrpgGmx13273532735eusmtip1B;
	Wed, 26 Mar 2025 11:26:54 +0000 (GMT)
Message-ID: <289d54b8-91eb-44cc-9304-355f1f865d4d@samsung.com>
Date: Wed, 26 Mar 2025 12:26:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
To: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
	<roger.pau@citrix.com>, Daniel Gomez <da.gomez@kernel.org>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Bjorn Helgaas
	<helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org, Bjorn Helgaas
	<bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87v7rxzct0.ffs@tglx>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djP87oNTx6nGxz4r2expCnD4vOGf2wW
	f6dlW7zY0M5o8erMWjaLaRvFLebcNLK4vGsOm8XZecfZLC4dWMBkMeP8YlaLzZumMlv82PCY
	1eL7lslMDnwe31v7WDxeT57A6LFgU6nHplWdbB7vzp1j95h3MtDj8IcrLB7v911l81i/5SqL
	x+dNch4nWr6wBnBHcdmkpOZklqUW6dslcGXMmK9ecFip4tiu3WwNjOukuxg5OSQETCQ2TTjK
	1MXIxSEksIJRYt6OS6wQzhdGiVXXPkE5nxklNu+YygLT0nH4BTtEYjmjxLJlh5ghnI+MEp++
	/WPrYuTg4BWwkzj+NwikgUVAVWLx1y2sIDavgKDEyZlPwAaJCshL3L81gx3EFhaIlNi46CXY
	HSIC7YwSZ2a9YQRxmAX+M0k0dc9lA6liFhCXuPVkPhOIzSZgKNH1tgsszimgJPH/5XUmiBp5
	ieats8EukhDYzynR/WAh2EUSAi4SP3sjIV4Qlnh1fAs7hC0jcXpyDwtEPdDmBb/vM0E4Exgl
	Gp7fYoSospa4c+4X2CBmAU2J9bv0IcKOElM7J7JDzOeTuPFWEOIGPolJ26YzQ4R5JTrahCCq
	1SRmHV8Ht/bghUvMExiVZiGFyywkX85C8s0shL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al
	6yXn525iBKa+0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4j7E+TBfiTUmsrEotyo8vKs1JLT7E
	KM3BoiTOu2h/a7qQQHpiSWp2ampBahFMlomDU6qBqak1o1nlbEDn/KwXAl5FqbzJO7mO5yQW
	Sa9fbZjh5hDndd9zvezfQ63VN5d99zvneO4M++bEmRMucYUJXC+UlbzxWapG8g3vn4MHgjLn
	znV4Zfer9HEDs8S9o5P/sRhlMX2UzSjIDfIXOaX3Mchs9U62ruRuxfkZlT/nPdsny6+56u+7
	J08+O6p3VrGt/Z1yZWF5s6fNIY//E/n2r9cXXhAf3WKbtoAv7lPbkXIhQbaK/ZF138s+ZnqF
	bHJf+ko2umh+tvbdf1f0G2d+s5+6V2GukMiC4BX1X0ILrDyN2N2/H+wtqD+2bJL3Fq3v8j+X
	3bKYrS1nnP7d6q88g9GJSzFvD/79U/yQ1bHeVey+EktxRqKhFnNRcSIAWalNN+wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7oNTx6nG6z7y26xpCnD4vOGf2wW
	f6dlW7zY0M5o8erMWjaLaRvFLebcNLK4vGsOm8XZecfZLC4dWMBkMeP8YlaLzZumMlv82PCY
	1eL7lslMDnwe31v7WDxeT57A6LFgU6nHplWdbB7vzp1j95h3MtDj8IcrLB7v911l81i/5SqL
	x+dNch4nWr6wBnBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZk
	lqUW6dsl6GXMmK9ecFip4tiu3WwNjOukuxg5OSQETCQ6Dr9g72Lk4hASWMoosfT0ZhaIhIzE
	yWkNrBC2sMSfa11sEEXvGSWOb7nL1MXIwcErYCdx/G8QSA2LgKrE4q9bwOp5BQQlTs58AjZH
	VEBe4v6tGewgtrBApMTGRS+ZQOaICHQySixvvcAC4jAL/GeS2PVqKjPEhttMEvc6n4K1MwuI
	S9x6Mp8JxGYTMJToegtyBicHp4CSxP+X15kgaswkurZ2MULY8hLNW2czT2AUmoXkkllIRs1C
	0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgdG+7djPLTsYV776qHeIkYmD8RCj
	BAezkgjvMdaH6UK8KYmVValF+fFFpTmpxYcYTYHBMZFZSjQ5H5hu8kriDc0MTA1NzCwNTC3N
	jJXEedmunE8TEkhPLEnNTk0tSC2C6WPi4JRqYNpmEcbf5u544/O/7kmMh/Zvv78l4tSxsG2s
	ldxRdidsuFVuhywsdIrnKo4ut1227YF9Rv3+v1cmXGfXYV9ybX1IbFrO5ddyX19c+TnT7k7c
	mt6COZb3C6M2talaLmM/MOvwgpev3m7afIyVuY1Fbu8BmY0savkB9480qWQF7LvPEVqms/HH
	JqYNS7OuLDl90KXP7NSWxKaFp9qmLrvpsSFut93Lkz88+0KeHjw+40aXdp7a6llT1xs+Wsbc
	2DHV/+5GY601TZJffqRG3FWPUXs+74KG/dkVNrN39f7iWeqTVulkmJF35mBLqWb0famm+lVS
	xin50hp26RxS6tlmSpP+bO/81iVyiP1Bn8jDumwlluKMREMt5qLiRABMzfnpfwMAAA==
X-CMS-MailID: 20250326112656eucas1p27c3b714ecf38ca2249c5aa1261ed3f7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250326112656eucas1p27c3b714ecf38ca2249c5aa1261ed3f7e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250326112656eucas1p27c3b714ecf38ca2249c5aa1261ed3f7e
References: <20250320210741.GA1099701@bhelgaas>
	<846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
	<qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
	<Z-GbuiIYEdqVRsHj@macbook.local>
	<kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
	<Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx> <87v7rxzct0.ffs@tglx>
	<CGME20250326112656eucas1p27c3b714ecf38ca2249c5aa1261ed3f7e@eucas1p2.samsung.com>

On 25.03.2025 10:20, Thomas Gleixner wrote:
> On Tue, Mar 25 2025 at 09:11, Thomas Gleixner wrote:
>> On Mon, Mar 24 2025 at 20:18, Roger Pau Monné wrote:
>>> On Mon, Mar 24, 2025 at 07:58:14PM +0100, Daniel Gomez wrote:
>>>> The issue is that info appears to be uninitialized. So, this worked for me:
>>> Indeed, irq_domain->host_data is NULL, there's no msi_domain_info.  As
>>> this is x86, I was expecting x86 ot always use
>>> x86_init_dev_msi_info(), but that doesn't seem to be the case.  I
>>> would like to better understand this.
>> Indeed. On x86 this should not happen at all. On architectures, which do
>> not use (hierarchical) interrupt domains, it will return NULL.
>>
>> So I really want to understand why this happens on x86 before such a
>> "fix" is deployed.
> So after staring at it some more it's clear. Without XEN, the domain
> returned is the MSI parent domain, which is the vector domain in that
> setup. That does not have a domain info set. But on legacy architectures
> there is not even a domain.
>
> It's really wonderful that we have a gazillion ways to manage the
> backends of PCI/MSI....
>
> So none of the suggested pointer checks will cover it correctly. Though
> there is already a function which allows to query MSI domain flags
> independent of the underlying insanity. Sorry for not catching it in
> review.
>
> Untested patch below.

This fixes the panic observed on ARM64 RK3568-based Odroid-M1 board 
(arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts) on next-20250325. 
Thanks!

Feel free to add to the final patch:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


>
> Thanks,
>
>          tglx
> ---
>   drivers/pci/msi/msi.c |   18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pc
>   static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>   			      struct irq_affinity_desc *masks)
>   {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
>   	struct msi_desc desc;
>   	u16 control;
>   
> @@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci
>   	/* Lies, damned lies, and MSIs */
>   	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>   		control |= PCI_MSI_FLAGS_MASKBIT;
> -	if (info->flags & MSI_FLAG_NO_MASK)
> +	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
>   		control &= ~PCI_MSI_FLAGS_MASKBIT;
>   
>   	desc.nvec_used			= nvec;
> @@ -605,20 +603,18 @@ static void __iomem *msix_map_region(str
>    */
>   void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
>   {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
> -
>   	desc->nvec_used				= 1;
>   	desc->pci.msi_attrib.is_msix		= 1;
>   	desc->pci.msi_attrib.is_64		= 1;
>   	desc->pci.msi_attrib.default_irq	= dev->irq;
>   	desc->pci.mask_base			= dev->msix_base;
> -	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
> -						  !desc->pci.msi_attrib.is_virtual;
>   
> -	if (desc->pci.msi_attrib.can_mask) {
> +
> +	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
> +	    !desc->pci.msi_attrib.is_virtual) {
>   		void __iomem *addr = pci_msix_desc_addr(desc);
>   
> +		desc->pci.msi_attrib.can_mask = true;
>   		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>   	}
>   }
> @@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct
>   static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>   				int nvec, struct irq_affinity *affd)
>   {
> -	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
> -	const struct msi_domain_info *info = d->host_data;
>   	int ret, tsize;
>   	u16 control;
>   
> @@ -747,7 +741,7 @@ static int msix_capability_init(struct p
>   	/* Disable INTX */
>   	pci_intx_for_msi(dev, 0);
>   
> -	if (!(info->flags & MSI_FLAG_NO_MASK)) {
> +	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
>   		/*
>   		 * Ensure that all table entries are masked to prevent
>   		 * stale entries from firing in a crash kernel.
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


