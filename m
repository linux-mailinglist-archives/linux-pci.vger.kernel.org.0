Return-Path: <linux-pci+bounces-9598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A039243E6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDAFB25DA4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046514293;
	Tue,  2 Jul 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keJ9mVKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0684BE5A;
	Tue,  2 Jul 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938841; cv=none; b=ZQmvAmQijDhjOeNpQZiAsN7Etsf6g0dxKrCxumHLHLMGNHMRSzIuFmRcyo1bI1zu1AzlvPU5q88Mour6iPsCE0T/cTXo4quHaM85kWNVEnL7cXBKqahC8MPLB/M0ZwulYvo3rHwa0FuqIhkIWrnP4VImevxFBPKhK/HxLV8MB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938841; c=relaxed/simple;
	bh=7XT7HtavjTruZQ6t5F+ajd/59W0k3DRNHaheC5zIhxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VnmAHnpGcZdUCSXAFLjgThvC47rSdtrem1JR+Tpha5sCCXxkc8Z58IfI6u1RV1Wpzuu/9xG4U29Ov4sAspdbSUkEKcxUtgZoo/1r92coJ6MflyGVCLfQIsE7kT0l9TlUksRy0z6fjsotVxlt+iaF3oT/Hn7dxJAyK7hHeTi97lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keJ9mVKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E0C116B1;
	Tue,  2 Jul 2024 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938841;
	bh=7XT7HtavjTruZQ6t5F+ajd/59W0k3DRNHaheC5zIhxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=keJ9mVKqh1Nuaa6Y4aMpFwWesr5E1DlvmJwayfvUh0z35Kz+qngOWT7DuJTyFw7Fn
	 lpTewpVTUkeuph99Y/ZaceT4D24w/00xMQVflRIOO2U1F/WxIzdziVooFTpYz8lLhg
	 H0hKqr3xM/cZhNgSaL5TWLdzBwVgT+qF+m0g3YCI51/An0Eh6ggJqbckhC5wI6Wirj
	 6KxawlHncVSwKgNlq+BACSo3a6+3xk6FlkO8xVJkDzk6DwtcxY3NvQZQTJzbZArUl/
	 5MuPYYOzJy6aVAThLy9aK8cQ6hx/AUtCyupElvnmd+cOn12JrHefnilb7lIZeWbcnA
	 OWGPZ5gUdOkYA==
Date: Tue, 2 Jul 2024 11:47:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH v6 0/2] cxl: Region bandwidth calculation for targets
 with shared upstream link
Message-ID: <20240702164718.GA24910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701215020.3813275-1-dave.jiang@intel.com>

On Mon, Jul 01, 2024 at 02:49:13PM -0700, Dave Jiang wrote:
> v6:
> - Update kdoc in comments. (Ira)
> - Various rearranging and cleanup of variable declarations. (Jonathan)

Housekeeping nit: it's helpful to include the diffstat in the cover
letter so I can tell whether I need to look at this, e.g., does it
affect the subsystem I worry about?  Also nice to have URLs and the
brief changelog for previous versions.

