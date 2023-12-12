Return-Path: <linux-pci+bounces-820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B380F920
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D23C281FAD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2E65A9E;
	Tue, 12 Dec 2023 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iigFE0sX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24F65A71
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 21:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D30C433C9;
	Tue, 12 Dec 2023 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416205;
	bh=/ixDf/FMAeVQ+/FH3AsNSPZ9BcC9ELGE9aI1dGNMoIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iigFE0sX/7WKAGE22E7MrW/4c+wXyqluQ6d6vh1soqeCaAKuY8p3R2ZL7ifRCIHzU
	 2z4n+o5thjK/+Sg3bN2ZegIK7cLBE/OG49Ee78lgIU1iyMjeMuZ3YDx3v29LPMKYKb
	 jph+hciZcuNVcxbCRZKjqmUB3Tnm9az5BwCWdw4bkMGLH/bFwWxGZCeL7xWbJ05kqA
	 gdcFiURxTcS4OuKVKRJgZgMSLa09fp9rCGzOdQE6q7UM7WzF/bNodABI+VNg9gxP+m
	 ckV1V0bh4Kz7bxLcvxjWzPbwinGk51fT1aYaeZ5G0T5adHKkVNXzTTtk1pC9B83dPw
	 55lJ4EVvwkHGg==
Date: Tue, 12 Dec 2023 15:23:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <Terry.Bowman@amd.com>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec
 terms for errors
Message-ID: <20231212212323.GA1021034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace772f1-475a-4d20-9bf3-3b9901d48dd7@amd.com>

On Tue, Dec 12, 2023 at 09:00:24AM -0600, Terry Bowman wrote:
> Hi Bjorn,
> 
> Will help prevent confusion. LGTM. 

Thanks a lot for taking a look at these!  I'd like to give you credit
in the log, e.g., "Reviewed-by: Terry Bowman <Terry.Bowman@amd.com>",
but I'm OCD enough that I don't want to translate "LGTM" into that all
by myself.

If you want that credit (and, I guess, the privilege of being cc'd
when we find that these patches break something :)), just reply again
with that actual "Reviewed-by:" text in it.

Bjorn

