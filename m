Return-Path: <linux-pci+bounces-20861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91903A2BC50
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50B167732
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF01A38E4;
	Fri,  7 Feb 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QCfHLlsN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726919047F
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913709; cv=none; b=tzPpxebMK2HUkz3jE6Vdy6PtoQ0Ipq8steoT6qgahCQTlQ2Vgojz2RK75S52AT0p0F3p34C6h0sCODSHdhbIFix7n24howrd3Y0RWr8ipxfklp/s3S+/DxhQmxa3psMng8IuWtdSIsi85X43xEkvlEPCCpFcT7Ah5A9at6yXt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913709; c=relaxed/simple;
	bh=SoKfZsMWM++7qSwG9M+ObHWZT0yu/xHXf31AK8qwgbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmaY4MqDYnKeolueKYNjzNxBT96nBsZIG8IzomBakmmXhW5CJ51I7eYrGyopgjjpeLapPRWHSWMzjoBBJf8oEoHCBadcHRx8zL/7IxVtXwQ4rgyx8JpxfWnk0yZcMBblZ+xdRC8tIxoRjrmW0Ib/8v1+4jgnhmWBRkVHBBLJRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QCfHLlsN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b7041273ddso159455485a.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 23:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738913705; x=1739518505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S985nb84gx3fKGG3CziKlQ8YyE/d/ai620mo1qQAcd4=;
        b=QCfHLlsNS44BCvA/g6cLK2H5qdHS+yYeSdTeIZi/Y9TILkmnJWw2AMDSt5bZ+Ur38j
         l5D7UK4DLD7dAUK0tiDHckeGtHwtMA3bm/EYGqI5nN1Bmre7BcsdydApo8snh67D9A1u
         XVI/b0r869E0B5qzXdczopOsNMZ1a/yhhtwJUy1nOzpSuLJhulwtpW7kJ0y8ocFi30PX
         F/J92ZnOsjIIfuSKa5kHRaWen+bxPvwMH7oeacQc5i3M+lPCK7d2hjUkIg8dZsygAZZv
         8n3cOzcLSE3jZp6lrB5IXvC9KXlk3krgeS0aVmiqiZuziTr9GrzEN95J+ORZYWTh8Ay8
         lntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913705; x=1739518505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S985nb84gx3fKGG3CziKlQ8YyE/d/ai620mo1qQAcd4=;
        b=SV30K/ZGrSHwFmlYqmMshFrEUXhxASfr8g1G7Jqb7omvN5RhT6wWr+TC1roocseCXD
         7bUIFEMs6xgj/UtHl14YWBVyI6MeisCI1A1yreWdzWMbNJEK6obxz556TCap4B25azxV
         Xxd8y+ccL0TnMl7cxdZFRXfShLtrrDzuXlhZrINL3d0FQDHofHiQq+TU4psj+jkE3wWO
         MtUHAD/hQjGIloW/dA+8vACIr6k2l3JbGXvjUbKnWiUbFJoZhfF+9SLDoxRGM3ASf5KM
         RmRujkXGi8FkWiwYjS9ILMczHrzCI/RyIRGgqU33FzkrddRfH2T+EK2LVqh2Z2wcwtbh
         AdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF5oPe8kcMZaieXjg1o04SkExp5Z/FHblwGW0PohxKOlJ9ZCAI+ctLNajPUO4P3BHGtzc9UcwMdaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ucwkcDWCNLIQAiNmNomn2hYCk8pfWrjxz1Zzn7srdjw2XAwl
	tjLysIFi72mddcrfLqe7TpYfC2E4Lg7w1sPFn/Q2xVv+wJCPqsqgZ8pa8hk8BJE=
X-Gm-Gg: ASbGnct/91bogXNPFWa32o7XlwUPLG2ROVZWSvHOvjRoR7Mnb2Jsb9epM7a6y9KyYAu
	BqVw5yfAQC0Ku8XsO855137zoSX9mv7YO+8BIIFXn9hr1hLbJHrDLHcJGPO7vm49JyJyhXFXLxl
	q/VIO+zPBXuZrCSLE+S6JrIetk97ngH+lW18jAmr96EszcjKUHRq1ReQzmO59O4A99ULwf/7ct8
	5ILbF/UAH0G5A6UXaQiNEUc32wSiAGilknOVb7YSBIuhe8cfbYoXn7dPKSsDZrrWpM8wYywOOH1
	n66KTAF/lPCf2BTK1L8Yn0H+S5Rm0MuSGLa++2RPqU9UNy+imXn4cTiQyPehk+WegYHmT0AHVw=
	=
X-Google-Smtp-Source: AGHT+IHR2VWtK5UoYrz7dJOeFMRcEgTDUb47l42Cs0Jrr9jUdPON+1TgDBAhn04WkWpQ6sv6zHS7uw==
X-Received: by 2002:a05:620a:4b45:b0:7b6:f03e:6c0e with SMTP id af79cd13be357-7c047bc6debmr252927585a.31.1738913705408;
        Thu, 06 Feb 2025 23:35:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec129sm157964185a.18.2025.02.06.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:35:05 -0800 (PST)
Date: Fri, 7 Feb 2025 02:35:03 -0500
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
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <Z6W3p1h9ghcBF_R6@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-10-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:45AM -0600, Terry Bowman wrote:
> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping AER
> registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


