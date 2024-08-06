Return-Path: <linux-pci+bounces-11373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C994960B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4061828186B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7646444;
	Tue,  6 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0fKF2zW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4322331;
	Tue,  6 Aug 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963665; cv=none; b=YGeRlK6eHOjjptQdfB3TL1PJtyGfb+QIadezpJsE3fVl00U1xlLheb+yyAzHK8fP3uOYJJ8TDJv5BGNzkSd4eCKVCyGZuOqQAXzWRU3Aq2VUTtL9IWd6FSnjs6nDvUDhkQkP6yHhUsKQEQDyfqiseqeiWDjITWGSuBPY+Z+xhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963665; c=relaxed/simple;
	bh=pM3b9Auvka/8pMpylfyKJfnfvvQhTGmGiWpgRX6L2uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdJgfb3EYAmAV/3W/mzzpv/dkg2roAth3PCsLBA5iILUExJgRkSuH92lHKwsge/fwxPwRtyAfAsfcRBKjrVH8+upINJJnG1U+r1tbrl5rPe7Yx8qUj8mbjdrZmIgW+3V+nhzeOLencTQvh5Jq8TgZssoB5GcNUMDCvdi96St2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0fKF2zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049D5C32786;
	Tue,  6 Aug 2024 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963665;
	bh=pM3b9Auvka/8pMpylfyKJfnfvvQhTGmGiWpgRX6L2uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0fKF2zWu3WRgSt/5HcQ5Te5cwhsiJVa51TcSn13q47yHy4I+BA1TQwFrXiBCWrK5
	 6G88pUL11WEK9c3VNXS9A7EaMe21IZ2h3hvX8DWvB4fLWxDmK2vDbnd1MfFX+jnAgp
	 G4flSODMl1ACQ6DskPho8VpcU9kqHeb+uixarN6a43w0A118piUFqVdC5/qIb5DXI8
	 uwma+F0MQOOGQ2xl8rVdo85jqmXpaPfB0VBmXgxMB6IkaAI5cxMgItrZLe1duXh19a
	 NqqObLuDQpLISEsh1PRvF4kGClx/KbXMHR7aBM473UqExXAZ9KwwBiS5AHR04l1WCG
	 kGHNT3jj53kwA==
Date: Tue, 6 Aug 2024 11:01:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: bhelgaas@google.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org, kw@linux.com,
	joyce.ooi@intel.com, dinguyen@kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: PCI: altera: Add binding for Agilex
Message-ID: <172296366337.1688753.6901920449833549042.robh@kernel.org>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
 <20240731143946.3478057-4-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143946.3478057-4-matthew.gerlach@linux.intel.com>


On Wed, 31 Jul 2024 09:39:42 -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add the compatible bindings for the three variants of Agilex
> PCIe Hard IP.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  .../devicetree/bindings/pci/altr,pcie-root-port.yaml     | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


