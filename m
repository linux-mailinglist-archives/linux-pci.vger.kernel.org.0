Return-Path: <linux-pci+bounces-29568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07910AD7865
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F1C1885AEC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B9298983;
	Thu, 12 Jun 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nnqA2QU0"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9052F4328;
	Thu, 12 Jun 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746512; cv=none; b=HxXh/ATH6UKKy9LmGpsYfUgZqCJij8260xheVffJyqCBUIf65eLNU6sbo8ctXD73WTmRn2IWhHrQhdZFZ7jO9R/vyjBw2kSNsiK9fdAd6fTd4zhsEC3MAPrLtpXxzs9cjPVAn6vAzsS4XACsfMjEqtQYOWaLuJVMmzhd79wk7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746512; c=relaxed/simple;
	bh=5t+OfqRxBNY0otd+hCK8+p6HJn7sVOoMugiU6orqbPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6dLMhCOTq3GweOha1/1EeS+jgq14QioixpbzEduQvNaD9YaE1yeMoKO95ScUHpAoQnhZuXvMOLQLdbSON8rixD9v5itpd6dVJG1J0p06eo3/jCka9jruy3MYYVZqzJUySY4ubFKW8dh+4tU4BcsW8618PD5EYH7GyrNBDb9uRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nnqA2QU0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.14.36] (unknown [70.37.26.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id C08C5201C775;
	Thu, 12 Jun 2025 09:41:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C08C5201C775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749746505;
	bh=rAURiPYzIbhtzpwq01PbrWPnhV9LWw4IG8DX+DBis4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnqA2QU0+L6Ka+53mgsErhf9aWZLvAG5xLwXHN5bA3B4jzTCWA1ZnQq1u42dJXLEb
	 cTwA5pvgcwMsRvkoQWw2tbnGY/9hanhK0QR8lgC8lFpkBHyqw7pQcYFq003Tzpdydr
	 +BlL/6BByrj2Cfnn75jq8R2ZXTt6Xhh8pJcUu/pg=
Message-ID: <57ad1095-89ba-4044-91ce-1ab37bcc79dd@linux.microsoft.com>
Date: Thu, 12 Jun 2025 09:41:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
 shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
 bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <aEj3kAy5bOXPA_1O@infradead.org> <aEku4RTXT-uitUSi@ryzen>
 <1ccbaac5-7866-42f6-b324-cb9e851579e6@linux.microsoft.com>
 <aEp0N2RNh1szW1Xy@infradead.org>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <aEp0N2RNh1szW1Xy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
>> We can ask our HW engineers to implement function readiness but we need
>> to be able to support exiting products, hence why posting it as a quirk.
> 
> Your report sounds like it works perfectly fine, it's just that you
> want to reduce the delay.  For that you'll need to stick to the standard
> methods instead of adding quirks, which are for buggy hardware that does
> not otherwise work.

Bjorn, what would you recommend as next steps here?


