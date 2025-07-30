Return-Path: <linux-pci+bounces-33158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BACEB15B1C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD10418A5B73
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8550292B52;
	Wed, 30 Jul 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/5jUloS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F64292B48;
	Wed, 30 Jul 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865942; cv=none; b=j5FdC+P5ERNZe1qd2nYC32NCMr7kD54j8SneOogqNRa7nivtko4gkMMojuSMjfx19AOM7LFYkeEY5QwEBZC5FTDJZ3kc4W0xsgKqnlZXEoOfH6aPmDhKiF6pcWC91dade0Sx+rBUxukUkpqP27PBSBgPfslZfgfWtsPBBRa3bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865942; c=relaxed/simple;
	bh=zT4NPRZ9FMf/6OItmdKPO5L1pWmoqk9QHmm4Af0TsIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHSdK8luAZ2VKZtVvZIZZqUgr8oRByt9KTUw8SoPKiO8s9VShk95WhSLwT7pY2l2Xygra5ca9sSP6972pHk2kOzTfHrr/miCw+5pmHS8pwWBAJHj8padffXIzhmCwV6plKXrrH0F5gRVrHQN+2CAgoUU7rpcmjR1fbtt+ciMakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/5jUloS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B6C4CEE7;
	Wed, 30 Jul 2025 08:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865942;
	bh=zT4NPRZ9FMf/6OItmdKPO5L1pWmoqk9QHmm4Af0TsIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m/5jUloSppv6eyK+1hX9XhjbR4IcMIsoyFre0AlROlWOpBerfvgINP56Ul0eWnUZg
	 3NcPCO02sfLYFVo0ehYnns8qROTmr5G2oONIEIWLkN8LR4ojxNS0TyWmr/9awAxRmc
	 7vVDlZ60VAvif2B3xGJIbqB6sUrq0Utxp7LTtCUIi+pDRoa7FdEOOPtWe36Mlce0fC
	 8L0AM3W0J24SxOFvQjw7OqciPVOie6yjKho7AvST6r7kdcSK+L8/MZUVKqKnYXKB66
	 bifB1pzxHbXedXKK/QQlTuBsIIv+JC1kZqyyt8tEttpdjYMBL5c17H829GJJaS7KBp
	 xwvmQPTgP2Tcg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform
 device driver
In-Reply-To: <20250729182244.00002f4f@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-13-aneesh.kumar@kernel.org>
 <20250729182244.00002f4f@huawei.com>
Date: Wed, 30 Jul 2025 14:28:55 +0530
Message-ID: <yq5ao6t29hrk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:49 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>

...

>> +
>> +#include "rmm-da.h"
>> +
>> +/* Number of streams that we can support at the hostbridge level */
>> +#define CCA_HB_PLATFORM_STREAMS 4
>> +
>> +/* Total number of stream id supported at root port level */
>> +#define MAX_STREAM_ID	256
>> +
>> +DEFINE_FREE(vfree, void *, if (!IS_ERR_OR_NULL(_T)) vfree(_T))
>> +static struct pci_tsm *cca_tsm_pci_probe(struct pci_dev *pdev)
>> +{
>> +	int rc;
>> +	struct pci_host_bridge *hb;
>> +	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) =3D NULL;
>
> Read the stuff in cleanup.h and work out why this needs
> changing to be inline below and not use this NULL pattern here
> (unless you like grumpy Linus ;)
>
> Note that with the err_out, even if you do that you'll still be
> breaking with the guidance doc (and actually causing undefined
> behavior :)  Get rid of those gotos if you want to use __free()
>
>

I=E2=80=99ve already fixed up similar cases by removing the goto based on c=
leanup.h
docs in other functions.I must have missed this one.

By the way, isn't using the `NULL` pattern acceptable when there are
no additional lock variables involved (ie, unwind order doesn't matter)?
Or should we always follow the pattern below regardless?

	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) =3D
		vcalloc(sizeof(*dsc_pf0), GFP_KERNEL);

-aneesh

