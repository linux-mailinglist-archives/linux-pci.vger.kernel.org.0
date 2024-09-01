Return-Path: <linux-pci+bounces-12568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C896790E
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DAF2817D1
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375017DFFC;
	Sun,  1 Sep 2024 16:39:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9F183092;
	Sun,  1 Sep 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208754; cv=none; b=O4NzGKogNRL/C0utI3WskaJ0EYaXEnIZMHPoFGvTSqOnEF+OVX4ZaVvLxarvv87wL9gpjCsfLAqJN6JFIenbh7inZP3d1B9aywzpxHBzVdMcbyxsX9VVPKAvzWZKsxu0opJEBXx2VOxpHGCMlr5Y2Bi7jXxUwW1pmGBKUra0t+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208754; c=relaxed/simple;
	bh=zIhIkoVXpvbfRozdweaTPuS9Czttm7pA83bjd33G17Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXSC4Y+sfQVrw5VJ0Is6t+nJyNQjLBl5MbYTUdK9IDW2NBGLLaahePYFQMHUJXUJ+knceHJIbIlCspEH9qxCQCdQHAcfp4y0nIXjGwBEMfNTrJt6ia905qZAZCpsx/zJUC3684BOtiQLI1hLU/bj9cg88Kl0mtc8vEdkmxw7UIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714302e7285so3172364b3a.2;
        Sun, 01 Sep 2024 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208753; x=1725813553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdQ9MmCX6g//66R+kXqtwpzYrNhfNVvRsZUbdkwW+/o=;
        b=wRE7iJ1E/poavYzFU5FdA38oVJlg1CyJJmb/IYTHjBLcyYEIglwjX9NjOOnNaBUQ9E
         K4eEqrdxrBatQ4ui4eESmJCvdhGoeutWkQS3e8QuwxliIdVb4beyazVdIGvr55aWwqTE
         8Ji4MP5iW5Kfay1f7alLmbShxhgqBMv/fHDWByhYO6XF0n9YNk5cSywAqPDNjOXYIl3m
         2ltJM9JHFiGcHHh6PyQCWwpvNLT2G/+JhhBkh/0lSGQwy+aF9yFH1zbptmcO92GvV2aS
         WLcVzVbVFXoqhfWPQ3inYy5tjZ/qYA/uaO09BCLh/ItpT2e2NLQfeotkyS2uH1pReh+t
         n6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX5wchVqhA8Vtg6PZ4jLjBmI2WAlBKwgd3OtuDQd94o75+7N0QxPIgeQ+bYfWcuhPGaKlRkZ8ccQYKxeUx@vger.kernel.org, AJvYcCWbvjdb/HvDWtcdZS0wU0J1jiFn5xIddKb4yFf/+oHCBT0WhUBZqTvjVz8mdiGwA4QYh6YONIovJn/N93Go@vger.kernel.org, AJvYcCXxzHtEJPaD4ePzMWZvoVe3lwwotTPzC2L7txXxKypinDgmoJeNUZ+W3uyciyeBD4zQusJmJyjsrTBq@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrJblzxhzuTyevNigEa17KD7yQZRvyEnoAuzCRTGt2v+GOPrO
	eJwpr4+dQD+EpY1CJURQnmn2+ZEi0+p66lOiDk834XfWcEWhE3gBxbSITTXxXRs=
X-Google-Smtp-Source: AGHT+IHDTtd3Bt3Ic/YtMPXlOPa79bdRbV2FfzYGXiQ4sv8MjhZBrNnxhKksIYesxf2EWpqAQ6Rnxw==
X-Received: by 2002:a05:6300:668c:b0:1cc:e9bc:256e with SMTP id adf61e73a8af0-1cce9bc26dfmr10516897637.30.1725208752645;
        Sun, 01 Sep 2024 09:39:12 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7821cesm6112899a12.55.2024.09.01.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:39:12 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:39:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_mrana@quicinc.com
Subject: Re: [PATCH v4] PCI: qcom: Disable mirroring of DBI and iATU register
 space in BAR region
Message-ID: <20240901163910.GD235729@rocinante>
References: <20240814220338.1969668-1-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814220338.1969668-1-quic_pyarlaga@quicinc.com>

Hello,

> PARF hardware block which is a wrapper on top of DWC PCIe controller
> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> register to get the size of the memory block to be mirrored and uses
> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> address of DBI and ATU space inside the memory block that is being
> mirrored.
> 
> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> boundary is used for BAR region then there could be an overlap of DBI and
> ATU address space that is getting mirrored and the BAR region. This
> results in DBI and ATU address space contents getting updated when a PCIe
> function driver tries updating the BAR/MMIO memory region. Reference
> memory map of the PCIe memory region with DBI and ATU address space
> overlapping BAR region is as below.
> 
>                         |---------------|
>                         |               |
>                         |               |
>         ------- --------|---------------|
>            |       |    |---------------|
>            |       |    |       DBI     |
>            |       |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |       |    |               |
>            |    PCIe    |               |---->2*SLV_ADDR_SPACE_SIZE
>            |    BAR/MMIO|---------------|
>            |    Region  |       ATU     |
>            |       |    |---------------|---->ATU_BASE_ADDR
>            |       |    |               |
>         PCIe       |    |---------------|
>         Memory     |    |       DBI     |
>         Region     |    |---------------|---->DBI_BASE_ADDR
>            |       |    |               |
>            |    --------|               |
>            |            |               |---->SLV_ADDR_SPACE_SIZE
>            |            |---------------|
>            |            |       ATU     |
>            |            |---------------|---->ATU_BASE_ADDR
>            |            |               |
>            |            |---------------|
>            |            |       DBI     |
>            |            |---------------|---->DBI_BASE_ADDR
>            |            |               |
>            |            |               |
>         ----------------|---------------|
>                         |               |
>                         |               |
>                         |               |
>                         |---------------|
> 
> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 
> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, program
> maximum possible size to this register by writing 0x80000000 to it(it
> considers only powers of 2 as values) to avoid mirroring DBI and ATU to
> BAR/MMIO region. Write the physical base address of DBI and ATU register
> blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR (default
> 0x1000) respectively to make sure DBI and ATU blocks are at expected
> memory locations.
> 
> The register offsets PARF_DBI_BASE_ADDR_V2, PARF_SLV_ADDR_SPACE_SIZE_V2
> and PARF_ATU_BASE_ADDR are applicable for platforms that use Qcom IP
> rev 1.9.0, 2.7.0 and 2.9.0. PARF_DBI_BASE_ADDR_V2 and
> PARF_SLV_ADDR_SPACE_SIZE_V2 are applicable for Qcom IP rev 2.3.3.
> PARF_DBI_BASE_ADDR and PARF_SLV_ADDR_SPACE_SIZE are applicable for Qcom
> IP rev 1.0.0, 2.3.2 and 2.4.0. Update init()/post_init() functions of the
> respective Qcom IP versions to program applicable PARF_DBI_BASE_ADDR,
> PARF_SLV_ADDR_SPACE_SIZE and PARF_ATU_BASE_ADDR register offsets. Update
> the SLV_ADDR_SPACE_SZ macro to 0x80000000 to set highest bit in
> PARF_SLV_ADDR_SPACE_SIZE register.
> 
> Cache DBI and iATU physical addresses in 'struct dw_pcie' so that
> pcie_qcom.c driver can program these addresses in the PARF_DBI_BASE_ADDR
> and PARF_ATU_BASE_ADDR registers.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region
      https://git.kernel.org/pci/pci/c/10ba0854c5e6

	Krzysztof

