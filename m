Return-Path: <linux-pci+bounces-4153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D547786A0F6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F195DB26101
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A414E2CF;
	Tue, 27 Feb 2024 20:41:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9414DFFD;
	Tue, 27 Feb 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066486; cv=none; b=fYxvDy7vDDjuaewkQHBhNMivF/2ZhJ9Mp0pLQET3mgYn/FuAmCQ1bz1GUkeKMtAn1QqEtG7sDKYQFAGMle1SXqoqOAsrTpnaSR+5Pt5NnEvETRJQqhozUcS3jAVyW+bdGxRdR9Oh1X9r9Awo2/a2LPrvlUMePi00nwpS7I+yHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066486; c=relaxed/simple;
	bh=jAqu3eZCLfAw08fyoxhcQMIAzo4phS5xxsvpvRyTAAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/VQL5cC14TzM1eF/fBub6HLA7Z+Q11XBpv18CQz6xagEnmcRgNGKLmGBDbjS4MHH81Kbnnd8fMXeoK+7ODnEXFgVA33KirEFek+ooT00Fv6J5XFublZzkXc7DsWa2afwHMWReU+1psf5Fv81l+TxL4TkMQctgdYMmp6X4g/Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 3DBAE2800B49D;
	Tue, 27 Feb 2024 21:41:16 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 307815D825B; Tue, 27 Feb 2024 21:41:16 +0100 (CET)
Date: Tue, 27 Feb 2024 21:41:16 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH kernel v2] pci/doe: Support discovery version
Message-ID: <20240227204116.GA30259@wunner.de>
References: <20240226033114.3100118-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226033114.3100118-1-aik@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 26, 2024 at 02:31:14PM +1100, Alexey Kardashevskiy wrote:
> Does PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER need to be in pci-regs.h?

Yes that's fine.


> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1144,6 +1144,7 @@
>  #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>  
>  #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000

"DISCOVER" duplicates the preceding "DISC", maybe just
"PCI_DOE_DATA_OBJECT_DISC_REQ_3_VERSION" for simplicity?


> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
>  			     u8 *protocol)
>  {
> +	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
> +				(capver >= 2) ? 2 : 0);
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> -				    *index);
> +				    *index) | disver;

Hm, why use a separate "disver" variable?  This could be combined
into a single statement.

Subject should probably be "PCI/DOE: Support discovery version 2".

Otherwise LGTM.

Thanks,

Lukas

