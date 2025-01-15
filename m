Return-Path: <linux-pci+bounces-19907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0268A12935
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE821888BD7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10215886D;
	Wed, 15 Jan 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2ft2g+Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601619067A
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960003; cv=none; b=flZaJRYpW4ZMfb7qo0MbEkYYCDWXnFWepks5Cmkvjdw/0IDE2C2xQ6lhhfTkxh6F+t8KvjoSBwvNkI0EGZ/CIcNXWpLK/KtUsXUVNlwOnMFtW5+QdjQef6BUNHkysHt9OKtk8R9TqyVQfzjyUSr7MzGs4VZNKsQ9hMHNF8WlulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960003; c=relaxed/simple;
	bh=UUmhAOp/9d8IyPORM/pw/ASyOkX0emHyPUpc0H/o4Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8osCJxxfvUemPZcCjCOnfE3ePtAdUbaC1N/FdQV+7eljQCypV0EoyJdo0DwPtkYswEpUyuqED4kX/xaTOw52piaA3gEN15nzZVTEv62FBw3ZiWQKvGtNSDPHKBVlcTbh4+fHf8yEdUhBwk+Z65RfC8MsY/c8niWGOT9Pk4k9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2ft2g+Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so127297825ad.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736960000; x=1737564800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jHpA5/slw+VGMAK3/7tWtafbPnnk0EZARyMlNKZMCYA=;
        b=s2ft2g+QBUmrORySdlfzfu7O4efBNXaumBbKY1V22I/ZWyyG+BVV7zRJaF9Oo9or/D
         y/M0m4wILGhYEko1y1vJFlMxtaelK/YTc7jl8mIk7RRGvVd7hqr+vFM85GFb7UV4hjlN
         iJ5TgjIDnCYPJsMq2MXgQDUZ00HiVhaqhOo/cOBSF3NO7zYmhlxIKutNKB89nFQ8hGlq
         o6tU2NH25/rekJcPjb67Dn07LmOLdG7+q3OGq/Qmoqp1tinvkMDeZZx4Mc5kQ9HL3MF7
         0MP7nf/ebMuXXQ+nLKGYpeV8K8qIDTa1P0desLJ6YWfh6ODB/yQKqUmO1LZbd94LrEkA
         5OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960000; x=1737564800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHpA5/slw+VGMAK3/7tWtafbPnnk0EZARyMlNKZMCYA=;
        b=Es7uQqNgBh0E4n/dABkaVan0G9Ppybh7AdjnRYpiVhsNmoktzmaQJt8HbHxbQzXWcR
         ARfrsJ9ufmCHM0Q5FXkl8RTUtguylOxZ+4yJpRVwi1VzbtGKv1jwvq5zPT935SGXv7FR
         tcm6pZ6mQGK0pkJ8QfO7qMW0da1NaUbYaKgFU52UHA9eg16Gft68RoZ33SCZAEA6exC9
         nIePcOoUpN6IbE3MX3Nl/h3zchYUQQvdLtQY7IkQ5d31MLznxTqr9zJtriMDaRkKNkrJ
         PyuW4yO8Pg/eD6AvIZu4Puv/rOngzY2J/+xouCKZ9vxXm0oLa+xbTX50E9FL0BNXFPnY
         QZeA==
X-Forwarded-Encrypted: i=1; AJvYcCWlyoqE5+ayunFqm0A9qRZTmEntJFRcPebXf8LKLEsvWRb1J9GRWhXmGKVunQszbN31RySlm7DSlws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFyVgknxA3fo7IUVd8DKmFld385n0EtaFcfqrem3vbTzxalO4
	d3pgRdT3Mf93zzAYrY5J13Pw97P4GOyb8ltvoSPWEv4lWmMqJFe9t0qId0pJLA==
X-Gm-Gg: ASbGncvEyN+vXv+BlId2nAt+tatZUpJpFimeDS9FXAuGocxOuwUqzzLNNZA5eCvrLmD
	wOlrcFuFkAI4mtFjLfPbw/A23sFO37OGCKUbaTPvQzPMi9Qf+wUmLrjviOxOhPIJ7txfjOkgeS2
	PvDoARhzIVp/WLkWK+DBzm3MTmct5Jv1nkwA21q5b5GI0GrGHMTqz2C5N2EOvU59mUOTJ4tqnDL
	Sh+ox22wn7yihuS76zUBBdBSX2wGjJUHfKi3XpcK5wKBnB/jxPacVqGzVXw0XRC16U=
X-Google-Smtp-Source: AGHT+IH0C0kwI5vCu9vduhVdIQr7dzg9CdPQcDrUpqVy0d6d07orFuTITrfqjn2D01hrdTrQdyvKew==
X-Received: by 2002:a05:6a00:84c6:b0:72d:80da:aee with SMTP id d2e1a72fcca58-72d80da1086mr5806726b3a.9.1736960000320;
        Wed, 15 Jan 2025 08:53:20 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d5047df6sm9994678a12.59.2025.01.15.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:53:19 -0800 (PST)
Date: Wed, 15 Jan 2025 22:23:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in DWC
Message-ID: <20250115165304.it64cc3ytj4nmh76@thinkpad>
References: <20241206074456.17401-1-shradha.t@samsung.com>
 <CGME20241206074242epcas5p35c4db25aade3f328a93475225c170bb7@epcas5p3.samsung.com>
 <20241206074456.17401-3-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206074456.17401-3-shradha.t@samsung.com>

On Fri, Dec 06, 2024 at 01:14:56PM +0530, Shradha Todi wrote:
> Add support to use the RASDES feature of DesignWare PCIe controller
> using debugfs entries.
> 
> RASDES is a vendor specific extended PCIe capability which reads the
> current hardware internal state of PCIe device. Following primary
> features are provided to userspace via debugfs:
> - Debug registers
> - Error injection
> - Statistical counters
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  Documentation/ABI/testing/debugfs-dwc-pcie    | 143 +++++
>  drivers/pci/controller/dwc/Kconfig            |  11 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
>  .../controller/dwc/pcie-designware-debugfs.h  |   0
>  drivers/pci/controller/dwc/pcie-designware.h  |  17 +
>  6 files changed, 716 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.h
> 
> diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie b/Documentation/ABI/testing/debugfs-dwc-pcie
> new file mode 100644
> index 000000000000..7da73ac8d40c
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> @@ -0,0 +1,143 @@
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked for detection.	Read
> +		will dump whether PHY indicates receiver detection on the

s/dump/return - for other similar attributes as well.

> +		selected lane.

So what is the behavior if the attribute is read before writing (selecting) any
lane? Same comment for other similar attributes below.

> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Write the lane number to be checked as valid or invalid. Read
> +		will dump the status of PIPE RXVALID signal of the selected lane.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	rasdes_event_counters is the directory which can be used to collect
> +		statistical data about the number of times a certain event has occurred
> +		in the controller. The list of possible events are:
> +
> +		1) EBUF Overflow
> +		2) EBUF Underrun
> +		3) Decode Error
> +		4) Running Disparity Error
> +		5) SKP OS Parity Error
> +		6) SYNC Header Error
> +		7) Rx Valid De-assertion
> +		8) CTL SKP OS Parity Error
> +		9) 1st Retimer Parity Error
> +		10) 2nd Retimer Parity Error
> +		11) Margin CRC and Parity Error
> +		12) Detect EI Infer
> +		13) Receiver Error
> +		14) RX Recovery Req
> +		15) N_FTS Timeout
> +		16) Framing Error
> +		17) Deskew Error
> +		18) Framing Error In L0
> +		19) Deskew Uncompleted Error
> +		20) Bad TLP
> +		21) LCRC Error
> +		22) Bad DLLP
> +		23) Replay Number Rollover
> +		24) Replay Timeout
> +		25) Rx Nak DLLP
> +		26) Tx Nak DLLP
> +		27) Retry TLP
> +		28) FC Timeout
> +		29) Poisoned TLP
> +		30) ECRC Error
> +		31) Unsupported Request
> +		32) Completer Abort
> +		33) Completion Timeout
> +		34) EBUF SKP Add
> +		35) EBUF SKP Del
> +
> +		counter_enable is RW. Write 1 to enable the event counter and write 0 to
> +		disable the event counter. Read will dump whether the counter is currently
> +		enabled	or disabled.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_value
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RO) Read will dump the current value of the event counter. To reset the counter,
> +		we can disable and re-enable the counter.

Avoid using 'we' in ABI documentation. This could be reworded as,

"To reset the counter, counter should be disabled and enabled back using
the 'counter_enable' attribute." 

> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/lane_select
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	(RW) Some lanes in the event list are lane specific events. These include
> +		events 1) - 11) and 34) - 35).
> +		Write lane number for which counter needs to be enabled/disabled/dumped.
> +		Read will dump the current selected lane number.
> +
> +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +Date:		December 2024
> +Contact:	Shradha Todi <shradha.t@samsung.com>
> +Description:	rasdes_err_inj is the directory which can be used to inject errors in the
> +		system. The possible errors that can be injected are:
> +
> +		1) TLP LCRC error injection TX Path - tx_lcrc
> +		2) 16b CRC error injection of ACK/NAK DLLP - b16_crc_dllp
> +		3) 16b CRC error injection of Update-FC DLLP - b16_crc_upd_fc
> +		4) TLP ECRC error injection TX Path - tx_ecrc
> +		5) TLP's FCRC error injection TX Path - fcrc_tlp
> +		6) Parity error of TSOS - parity_tsos
> +		7) Parity error on SKPOS - parity_skpos
> +		8) LCRC error injection RX Path - rx_lcrc
> +		9) ECRC error injection RX Path - rx_ecrc
> +		10) TLPs SEQ# error - tlp_err_seq
> +		11) DLLPS ACK/NAK SEQ# error - ack_nak_dllp_seq
> +		12) ACK/NAK DLLPs transmission block - ack_nak_dllp
> +		13) UpdateFC DLLPs transmission block - upd_fc_dllp
> +		14) Always transmission for NAK DLLP - nak_dllp
> +		15) Invert SYNC header - inv_sync_hdr_sym
> +		16) COM/PAD TS1 order set - com_pad_ts1
> +		17) COM/PAD TS2 order set - com_pad_ts2
> +		18) COM/FTS FTS order set - com_fts
> +		19) COM/IDL E-idle order set - com_idl
> +		20) END/EDB symbol - end_edb
> +		21) STP/SDP symbol - stp_sdp
> +		22) COM/SKP SKP order set - com_skp
> +		23) Posted TLP Header credit value control - posted_tlp_hdr
> +		24) Non-Posted TLP Header credit value control - non_post_tlp_hdr
> +		25) Completion TLP Header credit value control - cmpl_tlp_hdr
> +		26) Posted TLP Data credit value control - posted_tlp_data
> +		27) Non-Posted TLP Data credit value control - non_post_tlp_data
> +		28) Completion TLP Data credit value control - cmpl_tlp_data
> +		29) Generates duplicate TLPs - duplicate_dllp
> +		30) Generates Nullified TLPs - nullified_tlp
> +
> +		Each of the possible errors are WO files. Write to the file will prepare

s/file/attributes

> +		controller to inject the respective error in the next transmission of data.
> +		Parameter required to write will change in the following ways:
> +
> +		i) Errors 9) - 10) are sequence errors. The write command for these will be
> +
> +			echo <count> <diff> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> +			<diff>
> +				The difference to add or subtract from natural sequence number to
> +				generate sequence error. Range (-4095 : 4095)
> +
> +		ii) Errors 23) - 28) are credit value error insertions. Write command:
> +
> +			echo <count> <diff> <vc> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> +			<diff>
> +				The difference to add or subtract from UpdateFC credit value.
> +				Range (-4095 : 4095)
> +			<vc>
> +				Target VC number
> +
> +		iii) All other errors. Write command:
> +
> +			echo <count> > /sys/kernel/debug/dwc_pcie_<dev>/rasdes_err_inj/<error>
> +
> +			<count>
> +				Number of errors to be injected
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..9ab8d724fe0d 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,6 +6,17 @@ menu "DesignWare-based PCIe controllers"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_DEBUGFS
> +	default y
> +	depends on DEBUG_FS
> +	depends on PCIE_DW_HOST || PCIE_DW_EP
> +	bool "DWC PCIe debugfs entries"
> +	help
> +	  Enables debugfs entries for the DWC PCIe Controller.
> +	  These entries make use of the RAS features in the DW

s/DW/DWC

> +	  controller to help in debug, error injection and statistical
> +	  counters

Use 80 column width.

> +
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..54565eedc52c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> new file mode 100644
> index 000000000000..a93e29993f75
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe controller debugfs driver
> + *
> + * Copyright (C) 2024 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Shradha Todi <shradha.t@samsung.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-designware.h"
> +
> +#define SD_STATUS_L1LANE_REG		0xb0

Sort these definitions.

Rest looks good to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

