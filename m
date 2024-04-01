Return-Path: <linux-pci+bounces-5501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA11894773
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 00:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51BC2849D2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E356B8C;
	Mon,  1 Apr 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3PR5H6p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DB51016;
	Mon,  1 Apr 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011490; cv=none; b=b8LCNp6UbJOdZL8peyYfHS0G9JZD06XcUxRbujLOHfWsx2JMvxNej3waxS3AzOjQd4GMmaFsF4fTkCfcOYs78o90knliM0twhZCKAv3gc71n8GBkdsTyXsFChVOPApfg7tWYDJBx4zp6XnQNYRoLIdNATuh4Rq0Zuw6tbb8A9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011490; c=relaxed/simple;
	bh=eI5MsN85TsXU30wMhxjefSqPjw0emEgsFMRpCXt7WwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NH1Apb1WB4EmDD5T9ZvOAuATCHalBEjB4Uj+asclnbPLx4pNbqJC+9jkpZKzAH6xmRMMu0EeSVlzw9Nk7OUjaKquJAO6eciKoyVDLu6dQmTk6iM67ckf4Z+ll2ini0hQuDs4ykaR/VY+XUHi3ny/FXBQfxJHmVbFclpSBw4YwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3PR5H6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2925DC433F1;
	Mon,  1 Apr 2024 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712011489;
	bh=eI5MsN85TsXU30wMhxjefSqPjw0emEgsFMRpCXt7WwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T3PR5H6pZ4A2bpIRWtMsKe3tDzzHiF+xp3aP4mAXJY02KZMfDoEEwbazU77Sr+BVx
	 LrSgfASHY61airF6HySC/ky6v70+4X8ecESXNSk24kAyfz1JPBoZ/XXwGMumGXjNX4
	 calsdk4DBZTwuUbpMahJYZWUT9NczVwcTQBdxirHEK0NOgUj1BA3cymQ5aq0dqzdGQ
	 djVjxGiG6QX4FQS40GUa5CY7WqF38E7JXvpItgYMk9OKQ+wYYuaJurL0+VR1UxJVwU
	 PkDppxXNazbSMntXdF2uwklO3IWIqrRoO5yHqL9LedqAC2XesI9vJYjdMg7C8+jCFH
	 I+BA54SQNclfQ==
Date: Mon, 1 Apr 2024 17:44:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: joyce.ooi@intel.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: altera: covert to yaml
Message-ID: <20240401224447.GA1762763@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329170031.3379524-1-matthew.gerlach@linux.intel.com>

"git log --oneline Documentation/devicetree/bindings/pci/" says the
typical style would be:

  dt-bindings: PCI: altera: Convert to YAML

On Fri, Mar 29, 2024 at 12:00:31PM -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Covert the device tree bindings for the Altera Root
> Port controller from text to yaml.

s/covert/convert/ (both in subject and commit log).

Rewrap to fill 80 columns.

