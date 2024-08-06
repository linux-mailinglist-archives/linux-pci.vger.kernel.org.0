Return-Path: <linux-pci+bounces-11358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB3949352
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3835D288560
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716861BE875;
	Tue,  6 Aug 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWb9QRiZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2871D6DBA;
	Tue,  6 Aug 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955130; cv=none; b=OETc3/Aeyl8V1bpD1i/e66eeO6U14Vgfhd2+ePYydFyH/hnloOqDS6ufrQbou0H8Wp9ARPOloEJWcRKUP6jc5YTzwOons1Lv75+JNp5Rw86v1t7V1UscLVxeLK5cRPqKHAyIIEXln4G+HFUVhlNnunaj6aGOWtiauHJxJoAKIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955130; c=relaxed/simple;
	bh=/7z/K9ZWP/Tkga+P4ZvnXOn43GRNmy93Pa5HJ73/Q5c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ayYWm+vHhynxy0635aCguiWUqgzurOQqA4JzSPoLtRfeXB9ezBNy7xOrxFZILaVVLGaVsAoygMGcPRXMcQPi1cNGKKRBPIsF0llLL3rM9PneBAnYSFgR4E+HdCmcwezGXYAYJr42RUvAHJKakIRkZMR+937eV+PwXLYF6pPouCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWb9QRiZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722955129; x=1754491129;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/7z/K9ZWP/Tkga+P4ZvnXOn43GRNmy93Pa5HJ73/Q5c=;
  b=PWb9QRiZpl8EJltDt9Hvqt/AwBj3ps/eCy33p7on8RlxRJEwh7R4QGjZ
   68EE+IOInz6JIRUC1wv+pWP/vh/sxWJPzMUp0gUec1lVsEPqRVWHe+yO1
   olFFGfrhjwThWvZ5mH4wXXzQPfhguI+lLp/unypNPVZ6LyrwzPpgZC3qm
   Ad94YFJST/sWfYbKVrQBx9VRVRQbR3Je0sT0vW0tcMi/Uce6T0Ksb/SBW
   qgpmk90fiIEiIFnSd5o99nzxI9Tz55D1JMbrfC2gQ9WAAblKZWXb23Zae
   qq50D7jsHOOLHQR/1LUUs2dPpDGLD81Vst/lHrSOLYmXVbd/j4LJKn2R5
   g==;
X-CSE-ConnectionGUID: +57n3yYjT7CY9adLQtzJnQ==
X-CSE-MsgGUID: qCXURutuRe+g9J45SQU9Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21126991"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21126991"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:38:48 -0700
X-CSE-ConnectionGUID: uqTf3NraROG/7BD5d147rg==
X-CSE-MsgGUID: C6pc71mwQLiKkw3O/8lBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56225975"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:38:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Aug 2024 17:38:41 +0300 (EEST)
To: 412574090@163.com
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, xiongxin@kylinos.cn, 
    weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH] PCI: Add PCI_EXT_CAP_ID_PL_64GT define
In-Reply-To: <20240806022746.16353-1-412574090@163.com>
Message-ID: <04db5243-f522-00b4-ae12-991da3e67513@linux.intel.com>
References: <20240806022746.16353-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 6 Aug 2024, 412574090@163.com wrote:

> From: weiyufeng <weiyufeng@kylinos.cn>
> 
> PCIe r6.0, sec 7.7.7.1, defines a new 64.0 GT/s PCIe Extended Capability
> ID,Add the define for PCI_EXT_CAP_ID_PL_64GT for drivers that will want
> this whilst doing Gen6 accesses.
> 
> Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..cc875534dae1 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -741,6 +741,7 @@
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> +#define PCI_EXT_CAP_ID_PL_64GT  0x31    /* Physical Layer 64.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */

These should be in numerical order.

>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE

This was not adapted??

-- 
 i.


