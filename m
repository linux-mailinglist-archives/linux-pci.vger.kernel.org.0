Return-Path: <linux-pci+bounces-10750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E293BBB1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBF9281D8E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61BDEAC0;
	Thu, 25 Jul 2024 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5tUR8L9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360425740
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881208; cv=none; b=lrJl+qwqrtcJ/QkF1pRwnGBxnyZVD9Zl4VJhlWrp8U4+CjsJe+sv5yHJhUjBwMwcvzw/0rCwkkTHVzFZryPwxqPj3UBuTdH543iiP39mfhg40YtGtljEDlOMXoZ6j3q6PqReVDb5323wqbxk5ZTJxZWnjZZQqrrD80StHLStjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881208; c=relaxed/simple;
	bh=kY0fom2PT3ibinAtblwyjUOcEx2vyt9CB7IUtU19EF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBN35/9rg6IF27Sqd/gVIR8jWZM7yoQo1XAxHwLND6hKzUpfMek3/NQZ4KDAkXr+J7/IoNjqojBzBLI0TSzthB0JHh7BKuaXcbmtq1lOp3uA3OtA+PFg3bS4O7LuzaiHtWQu20D/hZPfVEo94s8oqfMvfz4Vp2t43Zvi/2ZYwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5tUR8L9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so356825a12.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 21:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721881206; x=1722486006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4DmP3fxtSOwdi96Nd0UuEVePAIBxvlXMyWHucrA0W0k=;
        b=r5tUR8L93LsJ6PPjDDtHK2JllOIecu+d7QrSwIaYRp7oYVVJxbypsi4MgW/RmDQ/mn
         G7OUN8ZxH0/+sITHKeKL8vJpHv7R11Ss704Bk0v+bm/uFERHMKtC51ZIQQdre/xjqRoH
         rhl3KTehZIOdSb0Gl624W56zIFe40T/ivWt00pQErld9syB9FsYU7axFzeLT27AfMwWw
         fjCTmYrQ/nvCJNjD58iVf+H4x3g3vjTEneDOChEQjuAFM8rTqLZ8o6nYOajs28j6kH4R
         1/yba9pt++ROTWwqMuu6ulWp9Jj6IDUcEjuElbjYEAgO3CPUYDuKBqOJxfJiZWXNbnvT
         4diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881206; x=1722486006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DmP3fxtSOwdi96Nd0UuEVePAIBxvlXMyWHucrA0W0k=;
        b=jSQQ0xwwZEtu93h0aIXrULrJp8eR1XEiMPzVTp6eZEFJt8xs5b7xKJlR9IG4fJA8ZX
         Tl2uVkCJ2AarYYThvuN/Hr7CR6m1mnLZOvb7NP47MMqVrurohrEuHpxqj0y8pD39DG1X
         KSYOwuwNWVFkPGhdu3n49OTZEJIKLhftH+zOnCaTkCtd2DrTb+MfjBsGepdYWsJrYybb
         36gD8uyZMfwN3HG4BkV0CICUnAoEXAS2z+14HR32Y2HZlSPTrErYwTsoTEpx0GO7s7HQ
         6vvlir+TDxGjQrKLFiRuUvo58GrvdoNJAUdwfQTzbBbVfz3WhKjeyu+D3cpm5JLTy1K3
         QqUA==
X-Forwarded-Encrypted: i=1; AJvYcCX4TDEIzMqXfEc27cDAFcvvflOo5+o6SNu+ICLZKzo934/etR2pOaN34ThgDXhomG3Tv9rRk74eSwu9BgOjOK2R0m5wD8giIz9e
X-Gm-Message-State: AOJu0YyIRT36Fd3d5tl/eA54z0nj+9DPrVzM4AUbDpSCtnUcp7nKl2Sh
	Wj2IncUikGzQrWfgnQ/PGXN0lsJlLpZweLifoL2Lbh1KSDygvOZWw1cHuScJUA==
X-Google-Smtp-Source: AGHT+IF9TZsz6K8Hhe8vA7NOEy3c5xlX4b0C9eOnbb45IRWGE/FRIYwhph7kpZbJ0Q9QImNE3lbUMQ==
X-Received: by 2002:a05:6a21:6b0b:b0:1c3:ff89:1fc5 with SMTP id adf61e73a8af0-1c47b1db237mr641329637.30.1721881206605;
        Wed, 24 Jul 2024 21:20:06 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7f66esm3964335ad.15.2024.07.24.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:20:06 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:50:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240725042001.GC2317@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724161916.GG3349@thinkpad>

On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> >   of_irq_parse_pci: failed with rc=-22
> > due to the absence of Legacy Interrupts in the device-tree.
> > 
> 
> Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> if 'map_irq' is set to NULL.
> 

Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
are described in DT? Then why are they not supported?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

