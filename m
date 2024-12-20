Return-Path: <linux-pci+bounces-18866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F669F8DCF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F56168986
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A14198845;
	Fri, 20 Dec 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYf9uKNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B11804A
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682604; cv=none; b=Km7+CWIOyEbKO7MrAuNBhd/9i0GfhnAOXIiQD3I7NW4qRmcQA1MSsID3hsr7VyTympWJ0aToLV+zU9Rq7hra8TmoQVbrLe4F7dgtpIpKixcFPs0f5kZDK+ulCq9hzNeAQaLpTjvuv8zigWOHvPaPKauehSrHt7LZ1ppuk5SZvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682604; c=relaxed/simple;
	bh=aEkDa9uN0kMmzFmXy54atB0s1LKp9lcKAtSJjfA0jwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqvV/yqZ7yXHvzu+cMVPmM1T3ARb0MJsxXuQF7U7VyndIEZN5BXBkWU8ZsJ9c1iDc1/zk0XTK0nQqVPjp19b5TnlE7/WmMmXl0f1cjjX+/0NKBnnnWLgNms0reDTMNRIEyLyrXAiMLf5G7e1lpdbTcn6qPKUBWwv4NWeOx9Ys3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYf9uKNm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216728b1836so13546125ad.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 00:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734682602; x=1735287402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MxscJpmY5uO8wZO4oXxpni8cg2MJMXxVI8cfdPWLHwM=;
        b=DYf9uKNmVCQWrcXN2n6rvq/0NC+N+h5uWkgAhJjkRyGB5FL/foWmyIobFuYnZLilt3
         IU/zABeVABnMKoI6OBNK9NL9DFEonqKlIZUV6Sv7y0kVKFh5m2Bw1nqxKmrNGrzBnVxh
         fS7oWhIz8L10kxMSdx4+IaA235lyzl5m7mHZ0ehFjj2fF3pAJnXGVPHYTbiMWAEQ2CTT
         Mi61SEUzx96rD+GiwdGaMWJ1V4Y41Aqw5+kdWO8Qx2dqLdxxzcJ0Qg5yhh/5RBBeF4tG
         J0qvE2jQUG8qWSGjwC+vW0vmW0SWGpYg9fqlnzSYCrbhU3f6+62Xq4CW9gxi7Hgd9juI
         jiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734682602; x=1735287402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxscJpmY5uO8wZO4oXxpni8cg2MJMXxVI8cfdPWLHwM=;
        b=MQflpJTvYtL6pnfUzAcMbpoYyqWk5UjsaSnLpV2vXfFiaEnyPwAoEjH5jfA1UYHQZL
         WjEiuIm9VzzCP90fml88dxO8rJpY7dG5Efw3VMxjgjoPuIpu5kEEkoNhAjAFOjB8lUKj
         trlgApvgsAwz+ZbpwJmGZVeaaKWaS1QVMG8ZahD4SSiAYS8uUb2mEaq0H/YL4sLlD3XQ
         M9VhLxl3kyLmVqaB3gvgJxpreVmJJjFWja7EWtZo5JJKCpBKPQkaURm5030XjqtTnjYh
         ygOUUmkDBrfAs9c+3AOK/uN9LU3tBLsR+j6G7+TrVLoR0MrAgoCixkx9Ux8/pdFHhsFn
         o+TA==
X-Forwarded-Encrypted: i=1; AJvYcCWYePVCyQVLGe2fVtCqLaA0NxC0WamKwb+wy9Z+dWHpey+LLzptLkbvAsW2X+E1poHqvo5MXsekyZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhU5fq8PxLVnupDdTGwMeIZsK/ejIrwWJ2G8Dx0Lb7c6LEaDr
	3pD8pVGZ3Q/MWi5uvVKwyvX/nuDTpT4BzaiJWH0tZLNQkvJX94Msc8sKrFC/ig==
X-Gm-Gg: ASbGncukcUIvqndjFOH9l8fJcaWItfOLWgvRx1JHXOdsvvyG2OuLrLkiob/+YW3sMdC
	v/mcWCW04r0ZCMtwzLJa3cuGi4RJFnxEfK023C28PenqckPje50plCEmOtWnfdAunO38afb8pR1
	GlJ1te7M5aEa4NbnzbA/L0DNPuwMZBlkkA7exNgONMWcl6RgM6fe7j0BA7AXgeG80eq18uHELzW
	bVPrWqFa5iIDFZWlbX28Q0IcvrnrsjEwACQ7UP5fHf7VlF7Fs5e9xQP8rHnjKykT1Dt
X-Google-Smtp-Source: AGHT+IHhSWc6owgfOBNABUpmvDLdbZxY9kQiP35jiZs+r2gN3KlwlEQZ+m5Odj3KuGMUJ0r1Nfmypw==
X-Received: by 2002:a17:902:e542:b0:215:65f3:27f2 with SMTP id d9443c01a7336-219e6e8c9bamr24090475ad.8.1734682602113;
        Fri, 20 Dec 2024 00:16:42 -0800 (PST)
Received: from thinkpad ([117.193.209.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7307sm23738985ad.195.2024.12.20.00.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 00:16:41 -0800 (PST)
Date: Fri, 20 Dec 2024 13:46:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <20241220081635.oaudrom74yp6t7ej@thinkpad>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220081229.pij52jwfdyeygux7@thinkpad>

On Fri, Dec 20, 2024 at 01:42:29PM +0530, Manivannan Sadhasivam wrote:

[...]

Sorry, forgot to trim my reply.

> > +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
> > +{
> > +	struct pci_epf *epf = nvme_epf->epf;
> > +
> > +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
> > +			  &epf->bar[BAR_0]);
> > +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
> > +	nvme_epf->reg_bar = NULL;
> 
> Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
> nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
> dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
> epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
> the EPF for platforms requiring refclk from host).
> 
> So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
> separate helper nvmet_pci_epf_free_bar() and call that only from
> nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).
> 
> With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
> setup.
> 
> - Mani

-- 
மணிவண்ணன் சதாசிவம்

