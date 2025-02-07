Return-Path: <linux-pci+bounces-20865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A512A2BD88
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF477A6128
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704E1991CF;
	Fri,  7 Feb 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h00gLq/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21737185B67
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915294; cv=none; b=sEf5D0nujsdoR8djzX/+UGBmXmlcsaFsNEjnd4qQobA6bWrkmJ93A8CUu5MLD4CH2+tszi30fGXuGRUTtkoDVeChkwe6hzfyi0J4Z0ITjLa22a0bn2+H6eBAXtCUVk+80jJ+RFubhyPJTOBXb+KS+wl6nxALwxrVkpHl7yqo768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915294; c=relaxed/simple;
	bh=+1Sc8DvEXSqZhxSPhaoZkti61/HFD7B/mhsc91OQR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0pxZB9v9UWs9NAcJsHCVm7yAuZdQLViliprqGmjxx3YQKtvXvX0m8A38VElPZFx7E4bYgFB9tMbB0bPjzqIx39oZEYu0BfeKEtMFERASayrHIYE6CRVPz3IlX6RujQSb+gqMe70ZjF0DhG64OdO8Mt86qymkZr8tVvH6dgoT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h00gLq/4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so13748446d6.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738915292; x=1739520092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53rCUEYLoP6SzGQ7dltS09SOj08LJRV41NYySfcgmkU=;
        b=h00gLq/4BHkrGLsQbD+eQFL+zXZcdYJg/nNfz3jfhyjbKJRsU38zlizAKV1dL0ypAX
         uEDtzv3OVKjH2YTXcToeWDv6CQuF+63K1KYatBacD0UpAEsfsfwdufuET4X6p8iKFDpH
         puUyfpxmfQ54a7TFNVU7MkaXlig1f4lWRpzMFjDJtS8+4NQG1rhzFnCMuptH5NVP9WXZ
         5UbMXAbsxbeSO5Yxgr/h/XmlPxoE1UGJUYmep+EfVK1HFUkaV1eOLN1Uy7yD8mz3prj1
         6h94jvBfSxzun92cm0+1a9i6pBEZMUkOQgiahYGzlHuDzqcCLoRaD13VJ8us/Tb3FOH2
         S1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738915292; x=1739520092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53rCUEYLoP6SzGQ7dltS09SOj08LJRV41NYySfcgmkU=;
        b=k/yijmw4A4DHFc+isLecX4TRXDj825Z5WfDhNp9oOzwDGbTWUkdhOgEtpSHhLmtLRP
         OFZrSRwsuPeanNfqCBMUoGPJ7cd5jHID3JoxyUzjZbhJ6aUzskDr6OdWPxSvAymZEmjx
         uCcgzoHCuD29XFXGj3QIy6u6W7HfF21trNIonIe06PUI1/J8kja7U4H4BhrYEvbRaKwr
         fDDFEAgczA5XlOPOwMx3/96TZFE5IZdELlPjWSARu63QPFFRZCClj+0QnUHkb/WP8Qq9
         ESVfoFv0Y3yH9GgRK0DXi6lg5zbbJNWMJhkR+OkLTnESeOILnWhSZNcpTr1lsgx88acr
         nPXg==
X-Forwarded-Encrypted: i=1; AJvYcCWYXDcpXCkl6hbh0YePpzEAgXjs98XNNBafmM7nWuL57oWSdTWv0601oQ9u5VI4+J9p7RqYIoBaBVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMbQOKLVLD8r+MsG3HO2QW9tpSKfRR1eqzXcTV3SATgcp0cQ6
	n3UwRHX9TRJJmLTgqvsM7nZzU46E1himqh9AnZYfEJhAlcnesg15290Y6LYElPo=
X-Gm-Gg: ASbGncuNYL3sC4P94oTNrV6lOdWJtDBfJcFCysbxSIYmDSXvbMBM20Ls9rSxnHKZbPk
	tasIg9dsRz3vyADxmk3pQwt6H3atu67FrCTwsNOHCkBkHU6dFRsT+gcsNHqh+zA8PcxWxjXElGZ
	uIz4ZVsG2sSfnghj+fAckfuNKE5Z3sI/ZpSJhvuHbdLsoXy0rWVxZ6fwQMRlx8lZf+UA6LymkNN
	/DpKnhLIQZoS1Ct7iEpIBUUtcGbVfdIuavZe9qOEHvu2Uv7Mu9/QyntYuOzD3xNXXj8sfXvbMMw
	9XaJcUQTCjoUrEmnnGWzcmli07TRdg4V7+jI7hqDuErf8uXmkI/E0jyh4YSrOIcmuNtSdkLSAw=
	=
X-Google-Smtp-Source: AGHT+IHVh9GKjiTCyuhbzPrNi9cz7oIOwuNi4yAC6Z7SgEopNjBBBR7Jr4474gD2P2gHYgAE+nm67Q==
X-Received: by 2002:ad4:5ce8:0:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6e4456fb76amr33866786d6.31.1738915292012;
        Fri, 07 Feb 2025 00:01:32 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babc865sm14190686d6.101.2025.02.07.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:01:31 -0800 (PST)
Date: Fri, 7 Feb 2025 03:01:28 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-14-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port;
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +		void __iomem *ras_base;
> +
> +		port = find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;

I'm fairly certain dport can come back here uninitialized, you
probably want to put this inside the `if (port)` block and 
pre-initialize dport to NULL.

> +		if (port)
> +			put_device(&port->dev);
> +		return ras_base;

You can probably even simplify this down to something like

		struct_cxl_dport *dport = NULL;

		port = find_cxl_port(&pdev->dev, &dport);
		if (port)
			put_device(&port->dev);

		return dport ? dport->regs.ras : NULL;


~Gregory

