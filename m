Return-Path: <linux-pci+bounces-673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF480A057
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A76D2816FA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB513AE4;
	Fri,  8 Dec 2023 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ku7jvIow"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0411D
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702030353; x=1733566353;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b/Y6KhG7ebTXUrPG5FLaeYG7qTOcY28lEmFgRpLbsBg=;
  b=ku7jvIow+ex4FBvmpbd/7UpBiFSXJSWEMQZN+oQsM4vHvY9TD6w0zWrp
   LGPGbqHnCndOvptYlzOTLx8frzonCEwrrAMU9R5FclRTL9b08mPoqfAPt
   Jppkdx9jBCFNcsXnMhDx4QKfapPV4taEGIL930PgarR89S7Ea1iS3sd1B
   Ino90K4UZYvDJ6gDemD0esCvwhfd4Ir2xjph7a6GsP4yjEL0C3tjBO785
   GjSEai3c9dKvYkkKlzfvha8LgOVfrrYzjnbkYybg06tLRMLXFh5XtRHDc
   PUraw6llrBTr5q9N6jtKI/l3xg6y3dlACsPTpVbh3bWrbA98WhnmhizSU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398254394"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="398254394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806355997"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="806355997"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:12:22 -0800
Date: Fri, 8 Dec 2023 12:10:47 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] lspci: Add PCIe 6.0 data rate (64 GT/s) also to
 LnkCap2
In-Reply-To: <20231208100631.2169-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <2f56e555-b99c-48b3-6d8c-3fdb5bee6a1@linux.intel.com>
References: <20231208100631.2169-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1044942064-1702030343=:1875"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1044942064-1702030343=:1875
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 8 Dec 2023, Ilpo Järvinen wrote:

> While commit cecfc33d9c8a ("lspci: Add PCIe 6.0 data rate (64 GT/s)

Please disregard this one! I'll send v2 with the correct hash (I played 
with my .gitconfig to get it always 12 char hashes and while doing so,
I managed to copy the wrong hash here).

-- 
 i.


> support") added 64 GT/s support to some registers, LnkCap2 Supported
> Link Speeds Vector was not included.
> 
> Add PCIe 6.0 data rate bit check also into
> cap_express_link2_speed_cap().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  ls-caps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index fce9502bd29a..2c99812c4ed2 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -1191,8 +1191,10 @@ static const char *cap_express_link2_speed_cap(int vector)
>     * permitted to skip support for any data rates between 2.5GT/s and the
>     * highest supported rate.
>     */
> -  if (vector & 0x60)
> +  if (vector & 0x40)
>      return "RsvdP";
> +  if (vector & 0x20)
> +    return "2.5-64GT/s";
>    if (vector & 0x10)
>      return "2.5-32GT/s";
>    if (vector & 0x08)
> 
--8323329-1044942064-1702030343=:1875--

