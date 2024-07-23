Return-Path: <linux-pci+bounces-10676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2C93A95C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3001F2210C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D8145B28;
	Tue, 23 Jul 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5py/4hH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DE288D1;
	Tue, 23 Jul 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773996; cv=none; b=SvJwhISdbOh0JAd4WNzQtmjv419SuEswgrHNr2gQnU0ZbcPQ9x8Pu0K3/m1fX9ldeyRpS0gK/9bFRSgOop/E7vN5W6kHUw675cfq4dl/pJGGq+rnCg0JRdcW02kuuvMuaXij5XSdeXtj3inFL3dM+QeumWT1s18YJyHVRu27024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773996; c=relaxed/simple;
	bh=P1edFubkU42gQM60THhmDmm1fEOb72Ql3vnXb72Yu5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CN8tPc2/tCRbm15wNa9C8UPDdbklVsATnbuRNmP9g+VWCmnfgstt+AVo/pGD+BMwWLu3a5AGax8nql5LiVQ6J6ngNIsESYrkAzH1/HUQkHZO+p8MvQJqXf6T6GwHKVSYDVYjizO1hidd9KA7xSso7eNHEl4xboIi8ksNI0+cpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5py/4hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E3EC4AF09;
	Tue, 23 Jul 2024 22:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773996;
	bh=P1edFubkU42gQM60THhmDmm1fEOb72Ql3vnXb72Yu5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t5py/4hHNHOiryPtmnllAD2G7xyTM5Ng/oRZB3cYWw46Zb++/Zz9dMNEghtTaw7CY
	 BgDtiQxVbPS5HHTDzX9hLV7vm5z9toTzvYOlCY+laxho+pOyx1k3gQo3WChhOzbLAt
	 s4gqoIERdgORn/cgjP4x9ezNZUYf4/hhbCOXL7Qp6jwLze11umJkuIT/UDVv0aUFdy
	 w/9PY/pBSFmOSSTPo9McASPipOTi/AuPu1JTmYJeLSfaXTjWVn9AiZ9Ee6lYH1pf2g
	 45bsAxvtU3zyUMYUHvRkYOJ3vFIPkTFpUm2H4/6212eLC+cuDY/gM0SFvz1lJCkwy9
	 e+6fwzwZnu+pQ==
Date: Tue, 23 Jul 2024 17:33:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 02/10] PCI: Add TPH related register definition
Message-ID: <20240723223313.GA779521@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-3-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:03PM -0500, Wei Huang wrote:
> Linux has some basic, but incomplete, definition for the TPH Requester
> capability registers. Also the control registers of TPH Requester and
> the TPH Completer are missing. Add all required definitions to support
> TPH without changing the existing uapi.

> +#define  PCI_TPH_CAP_NO_ST	0x00000001 /* no ST mode supported */
> +#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* interrupt vector mode supported */
> +#define  PCI_TPH_CAP_DS		0x00000004 /* device specific mode supported */

Capitalize to match spec usage.  Also below.

> +#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* extended TPH requestor supported */

s/requestor/requester/

> +#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* location mask */
> +#define   PCI_TPH_LOC_NONE	0x00000000 /* no location */
> +#define   PCI_TPH_LOC_CAP	0x00000200 /* in capability */
> +#define   PCI_TPH_LOC_MSIX	0x00000400 /* in MSI-X */
>  #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
>  #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
>  #define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
>  
> +#define PCI_TPH_CTRL		8	/* control register */
> +#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST mode select mask */
> +#define   PCI_TPH_NO_ST_MODE		0x0 /*  no ST mode */
> +#define   PCI_TPH_INT_VEC_MODE		0x1 /*  interrupt vector mode */
> +#define   PCI_TPH_DEV_SPEC_MODE		0x2 /*  device specific mode */
> +#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH requester mask */
> +#define   PCI_TPH_REQ_DISABLE		0x0 /*  no TPH request allowed */
> +#define   PCI_TPH_REQ_TPH_ONLY		0x1 /*  8-bit TPH tags allowed */
> +#define   PCI_TPH_REQ_EXT_TPH		0x3 /*  16-bit TPH tags allowed */
> +
>  /* Downstream Port Containment */
>  #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
>  #define PCI_EXP_DPC_IRQ			0x001F	/* Interrupt Message Number */
> -- 
> 2.45.1
> 

