Return-Path: <linux-pci+bounces-29365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D792BAD437A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 22:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBA23A514A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757C228CBE;
	Tue, 10 Jun 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ64FALV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411026461F;
	Tue, 10 Jun 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586188; cv=none; b=FS3HYN7VzWv9737a+nvpnTRiPrs6zm5X8an6dqJF4rTBmZfd+X10v4z1zSQQ8Qm2o3ndbgQ38OnoItQCGgKcCGvPTgP2lhyTr2WxnscQUMlb/nQmgtYcZcGWiPOLyaLgJvEXi+wtEnAVr4Ox/udbcwdsa0Ak0Va6insBniJnhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586188; c=relaxed/simple;
	bh=BF4ebzE5J02kfpo+7LYdZQLJRLcOjwrSS7LrYUuSOow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppmX3OcLlvpZ2Xah71td9ouwCImyenXuAA8SORfCdZhrU+bhAWsTIMrITucTeRG/DNukNP3TaW2TjWEVAOckiXT0IzB3Tar3m6uGqKPbvTKyoL0B4+A2752Y7aCvik6lIaQkEBf3MaPk70F06K/TZrjB4JgBovWWf9uYEvrf6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ64FALV; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e77d1333aeso1294148137.0;
        Tue, 10 Jun 2025 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749586186; x=1750190986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onIW15zIgWh9y4m8I19gLR8x0h7nD9fwx7MT+3ezukQ=;
        b=GZ64FALV3etEzHmKLyFwAL0/xaM6Tq5cMd/saTZlxmnhMuRfZzMYBgOX8T6JwpPR7j
         tzQa9MNmPLMAIp63nqwg8HVnPsKW9mKyNZ/AjSQlVnGdAB8IEk7rO+hgwSutaLbUzW2R
         tnokfG5b69LV5VdYmS/lLRhi7dHS07CjvN/bSc/CNACpYDrYe8qIVD9+UoYUBSJE3HLI
         7TfFbqaBvhioWRiRLV7FwvGS7U91QSYlU30bYV2njh3Wcg/z2k+zzhjTUy1agRXxtgsg
         BHmJMQiiD2KUh+8+l876IYZPoaZBiGrIKglJn0Q8zAz2NgDO8PtSjq5qgHZEmNRYx1yF
         s78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749586186; x=1750190986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onIW15zIgWh9y4m8I19gLR8x0h7nD9fwx7MT+3ezukQ=;
        b=mgUWi3g0b6UOggjAMPu+OeMEzfwwqaOVl6DadbJ3TXCxOTVkztC9QmbYXxue7sO27V
         sNxZjO1tLQw59prqbq4apniGaU3eG2OcD6QUXeNestwX96F05KhvD2I7x4Sg/Z1LepBf
         2Hm6wPCgi6jbd57nuMaXv0/irxUNixQXqmkc9Z8MCm86vGSroac0VFwh+mwB5WGv45US
         gilqeJLOTEF81G2hRrGU4VyL3Af9Q2mIirwZWYGMsZQPHGCpkLrgNTtIn0Kh7nXqaY/F
         Dak+KBYPvyRMAo8SVwHSVw3ZNOOiUNZs9n1fiiPoL3x1soeW0FCEvdTiNqcFMsIxg9js
         bjPA==
X-Forwarded-Encrypted: i=1; AJvYcCVTZSWoz71/YZsTMVXyEGgvbhkAkXJ7q26GjzuZ17s2TgfeJ7W1vVGqGxQxFsFlcKGgAEao9/RRFdTtYfA=@vger.kernel.org, AJvYcCVwSyHBXvWz5aUoLY9IrH7S6UzfDy6vE6pJoFwYu6M16gr01NIS7GjNmNQEmQVxm78uaqw/fuzn8PXk@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMUJ//KF12iacS/uC743k9WmCbJOEPXxrGH2Oy/MJRuyRMmm1
	uIxh0KbDWu7Tr+thGeJhSY8dlsydODG4gturjEmDesRBDGHRw+8Sw+Ne03SwdakB
X-Gm-Gg: ASbGncstxmr36RVQb4gaoPq133DnnNrmWpsZ0EC/ZGDJo8lsj6h1GFlUM8rCsLaMMLj
	vhZO90lxJXtkEz/flziX86azZnYJhz0HiUBAYpJvHnRZHmBf5q/RTgwn6lOVz8Gq7mpTHj2m1PL
	9iiq/XB7nKfwwk2FVuvkptKgi9e8SrMM+DNKPSYra39EMQ7Mz1JTsvH+JANRQF4BD3FetieKpGv
	5E6NWhjVEjii3wAcsD5Z8uGr/jEQmorpNqP12FrCcBQmo5vxcc/tgTzBskD+0YMkSJhEJ8GQy8C
	34BG+hl1881LJ2W6ud9wa63lwjRmx0YBpD7o5r/8K8byzzL7aw==
X-Google-Smtp-Source: AGHT+IHUV0h6pUokxy2glzd7NxnrUeGLDfesDcxJume/7YrS3hfExuee3amFE7vpuIxwPxM1+Rw3pw==
X-Received: by 2002:a05:6102:5087:b0:4e5:9149:7cb3 with SMTP id ada2fe7eead31-4e7bbae5e67mr513405137.13.1749586185785;
        Tue, 10 Jun 2025 13:09:45 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5a56::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeaf97af8sm1835615241.33.2025.06.10.13.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 13:09:45 -0700 (PDT)
Date: Tue, 10 Jun 2025 17:09:39 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] PCI: pcie-rockchip: add bits for Target Link
 Speed in LCS_2
Message-ID: <aEiRA2u3Dh8F6Ie0@geday>
References: <aEQb5kEOCJNQJMin@geday>
 <20250610200744.GA820589@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610200744.GA820589@bhelgaas>

On Tue, Jun 10, 2025 at 03:07:44PM -0500, Bjorn Helgaas wrote:
> This stuff:
> 
>   #define PCIE_RC_CONFIG_DCR              (PCIE_RC_CONFIG_BASE + 0xc4)
>   #define PCIE_RC_CONFIG_DCSR             (PCIE_RC_CONFIG_BASE + 0xc8)
>   #define PCIE_RC_CONFIG_LINK_CAP         (PCIE_RC_CONFIG_BASE + 0xcc)
>   #define PCIE_RC_CONFIG_LCS              (PCIE_RC_CONFIG_BASE + 0xd0)
>   #define PCIE_RC_CONFIG_LCS_2            (PCIE_RC_CONFIG_BASE + 0xf0)
> 
> *Looks* like it might be duplicates of:
> 
>   #define PCI_EXP_DEVCAP          0x04    /* Device capabilities */
>   #define PCI_EXP_DEVCTL          0x08    /* Device Control */
>   #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
>   #define PCI_EXP_LNKCTL          0x10    /* Link Control */
>   #define PCI_EXP_LNKCTL2         0x30    /* Link Control 2 */
> 
> where the PCIe Capability is at (PCIE_RC_CONFIG_BASE + 0xc0).
> 
> If so, can you please rework these to use the existing PCI_EXP_*
> definitions, including the fields inside?

Hi Bjorn,

I'll look into it, good catch indeed.

Thank you for your help!
Geraldo Nascimento

