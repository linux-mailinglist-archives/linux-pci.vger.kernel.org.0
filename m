Return-Path: <linux-pci+bounces-37221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0CBAA392
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 19:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E537A69F3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7E17A2E0;
	Mon, 29 Sep 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RvKAuoui"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74491D435F
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167992; cv=none; b=U4isn8VKodMsO3DyLbWrspwROJzgIIxPidvil5CzXf4tgbhwSd07A9LFuwTG3Gl8ozQ/MVV2uO47vZcx1FhRl2voPmfIb7cL8vgSe89DFyf9PqD1igcOPwXgvHqEzRpJ1PDHmVjIgp35SYPGwgj/LxVkI23OA/iuehXI06nNyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167992; c=relaxed/simple;
	bh=H3LBXvT182wT0ex9LDutokYOCnXgq0ndAm+2Ud0WjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj0LeeY/9AcNc/kZEssd8UFJFoqOUSv6azb+IEQfg/LP02TCsgEsd72fRn3Lh25U7b9UwNb86apQID/wJLXDmq+AitRbZG4Qi509Q8oVWWOhoHca9vKYsSY0fyKlRSvH5Cj8LfH6b1T8pthwHCxnNliIaEYZuO9NIZ55oE07leI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RvKAuoui; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4d142e9903fso33591981cf.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759167989; x=1759772789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=RvKAuouiVKvoTWmTAMSZtSVx9QKL7nNS3k9xg+Nt/I7ZRwsXKgnChnDj0JcnrriSlr
         4WQlkNHQbm6ENBK9ovjtLK9BBgHj46JDfkVThVbTd/+lSb1t0AMQgowhpjncrV3tIFKc
         VJ8v8e6k+gHAcuzDPRlEl03It8IwWeH9YQxnIKxOPY/Zl3FISCC1nV/rl2ZbY8CoBgJG
         T0zuqpUH0LQhztGU2qISPn4mK7S9RDvzhSj7SVX/ILOgrtD+6kbfElI5VQxsD3D2m2Vb
         SUJkW5VX/5MrqzssD/xdDIHvdqTMa4VdqTezM5kQ3qb/XfI8jpSBciUyfJa9kkYakDyz
         ha1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167989; x=1759772789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekGW8DgI6WebvQt3SE7n7wwqZhBDCV4b8cIcqpBzX1Y=;
        b=AG6cPcvnAf8YBCCN6Y1nTJSOtxqwrAGIE7cq0+n+9ZpvrdHbpJShZnEdSU+HRuMCV+
         AlKwIM6BBNKXm5xVjAQpANvcWS6+fleq0Dxl21HuYubf/zlVZ2ZheIauSCITp/Sojg5W
         y/4W82ubb6iS3PRjVNLcWVViNf5FpRESRKUdsAFTzFTpdUHhkcYyNKAZeQyCr0JJlfHJ
         j2HXhhGt5iYZPjj62Q69bPn4eSqVNQ6mxdSVSp0kFguaLhqkodGDCOJupdlnccPHPPj7
         WjRw/4og22MQj3mrKQpV8RXZ95ID2faTKhOes1PDo4bAy9NHXoinAPTxAZZr3SMQtrs/
         t5DA==
X-Forwarded-Encrypted: i=1; AJvYcCX0sqWBVyCHowR7nKsCTB/Ns9R0bcyJWOKtQAJop+eWUEbP4tyvgrRv9JNYKBpcf5h0BpvZ7cRmEXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyveOLmRUFEN2RFqjwHgdPU751Jfzg6XxooK5nxdQKJdqZ2bSik
	Jh7LPHQJE69hFwaV4mBDnZoFt85HVJKu46ngwt9x3JO5fNtUEyi4JXYJhQmAF0e+e2M=
X-Gm-Gg: ASbGncv9QTxQoRNGZ6Nek52t5hhju6Yz3GkgQjs9MofwLFEwRjC7IvfOngJdd6Tfc/q
	vORNUayKW5R/e4q25aFgbrdzRrU+JRdKDNhF0ivz1Q1dL+/y/MzJEXXfkCiabdF9+iZxEb/p0PC
	G1kqJOv+/Rz54EtslyF+FMdYE6AzbPQCYuMvt5EJsxg37ihibFDIbivYqqOhxFH5MwIomqAnA91
	YGTi276tLnYZ4M8+d4G6rfe45EFsrSG3PzQgBGGrvBm/A7S6kD/txv76hPPYY4RC589k8KD4eiw
	g8p/5s1NwV87yREX/KkKtacHTSLkDFXraf8V/TJB9MV8jnMssrg1OogSL34+xRkoXdG7QCX/Hvt
	WNTQXQhk=
X-Google-Smtp-Source: AGHT+IGV5bd0OxOxeha94oMHGR7r6z2JQMG5YvjTqqBPp/nfSpSoj6eA3rdVJdGjuygNySyB8mMM0w==
X-Received: by 2002:a05:622a:15c8:b0:4de:f1eb:e296 with SMTP id d75a77b69052e-4def1ebe887mr122193321cf.77.1759167989475;
        Mon, 29 Sep 2025 10:46:29 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b641asm844443385a.37.2025.09.29.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3HxD-0000000CNky-1poo;
	Mon, 29 Sep 2025 14:46:27 -0300
Date: Mon, 29 Sep 2025 14:46:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <20250929174627.GI2695987@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
>  static int pci_liveupdate_prepare(void *arg, u64 *data)
>  {
> +	LIST_HEAD(requested_devices);
> +
>  	pr_info("prepare data[%llx]\n", *data);
> +
> +	pci_lock_rescan_remove();
> +	down_write(&pci_bus_sem);
> +
> +	build_liveupdate_devices(&requested_devices);
> +	cleanup_liveupdate_devices(&requested_devices);
> +
> +	up_write(&pci_bus_sem);
> +	pci_unlock_rescan_remove();
>  	return 0;
>  }

This doesn't seem conceptually right, PCI should not be preserving
everything. Only devices and their related hierarchy that are opted
into live update by iommufd should be preserved.

Jason

