Return-Path: <linux-pci+bounces-22258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4BBA42CEA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5AA3ACB8F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268B204F8B;
	Mon, 24 Feb 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKf6E7Gc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBF1F3D45;
	Mon, 24 Feb 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426187; cv=none; b=MNuuVExiU9+L/OSBabVVFJzvKUJT6u3L8TJOSa1f5jtoffc+k1IMo6cBRLEEr3YhHk1iFaJxEYEVDxUrKNECcJnJHmxteywjchIPl2TnTRyj/CJ+xsVWm02uQenoXrjZKCLG9S2ltwtt2Q9soC3P9s9s2aAOPwjG4m4teNb8xa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426187; c=relaxed/simple;
	bh=f90Hn38Tq9+2tN/TZJiAHQjfIgYjPB9Pf+J4MmnEJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LtWc73/vBMZy9Cu5PG9WMKPvx9FnI9kimo21H5poqnRwMpnyS8YPhS9gAdqJn5k8jjgvtlhH6Eh0WrkZXWDzavtU/Nd2+Ey2XVuK5wtCNLGPrOr+oAxh6Y0iacE7G9kSorn6OTz5hD8cb3QfCNSsac2UxqBPcuVa9LBGEj+SKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKf6E7Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE26C4CED6;
	Mon, 24 Feb 2025 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426186;
	bh=f90Hn38Tq9+2tN/TZJiAHQjfIgYjPB9Pf+J4MmnEJAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XKf6E7GccM3hW6b/BnVduyU/8Lnlqf5+P98RjmurB6N8mNrfcSW/kygI0ugFw5wyr
	 Gyl7NSMZUhPHXiRoLo2zH0EBhk3JOsGvqELr3G5RRfDCPrqkB2B7BCwe+QdyH49cGd
	 WgUuTR51bWtIu6uEqG5DgHDAAeYQcSHGZq6I6ESLn6pkiyjQieaWxqE/1T+QUolfa+
	 HJnHSbpJw9k7OY0O2zIpOaekdh3A1uXDg7TmPaoc4EoiLnFstayIIy0SvM8eocz6M5
	 iUrRR8riKvVHujEXfl1etp6pksw9WozrGUiZn8sQsxu+SJ/HoVmBPk/AKsaMyciywO
	 4vcwITQmGLfHg==
Date: Mon, 24 Feb 2025 13:43:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, kam.nasim@intel.com
Subject: Re: [RFC 3/6] drm/xe/vrsr: Apis to init and enable VRSR feature
Message-ID: <20250224194305.GA473249@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-4-anshuman.gupta@intel.com>

s/Apis/APIs/ in subject to match common usage and use below.

Also perhaps s/Detect vrsr/Detect VRSR/ in previous patch subject to
match this one.

On Mon, Feb 24, 2025 at 10:18:46PM +0530, Anshuman Gupta wrote:
> From: Badal Nilawar <badal.nilawar@intel.com>
> 
> APIs to enable and initialize VRSR feature.

I always think it's nice when the commit log includes the actual names
of the APIs being added so we don't have to grub that out of the
patch.

