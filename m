Return-Path: <linux-pci+bounces-31335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5FBAF6B4E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E614A1C62
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58E1F0E4B;
	Thu,  3 Jul 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCl5PDXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E71CD1F;
	Thu,  3 Jul 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527165; cv=none; b=PK4SMdPCamXf6y8tM0Z2Rh4pAeSlc/bHTUDVHK3GfTpCgiZc6/ugVrgnvmqP3HfMsktiakzZ4hgNbsXUifdsi5klgwhKqYzr2DZ0zapo7kGKElvJN47i65h38TmTN7+N+wO8ms/poTkCpqyd5IhpVx4m74GsDYvg5vRvCwku3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527165; c=relaxed/simple;
	bh=7Sa87NwDkUNSqX9iveqSIc+b2HXXnPaRDFnBapNfQb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvI1eLf2v8nYOeAny+1Ms0UAho052CvqXFRZXtQZxxhpF3wT5r0L4O6KH7Sv8LK43sWQTVzoKmSWonDodbZsO2TeRo7k3rbvhfZ7+QQPvDRlZzOd+7C29UlpEKmF43pqPNlR/srSWraxEb4k/fARxyCBlKO63gmItweoGsKSoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCl5PDXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F2CC4CEE3;
	Thu,  3 Jul 2025 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751527165;
	bh=7Sa87NwDkUNSqX9iveqSIc+b2HXXnPaRDFnBapNfQb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCl5PDXAk6hm0uXI3YNOOYxQ+QItATqV6RKCYpGZLVYmTdWLc28SGZRLDocDJEhkN
	 YPdPK4zFGQMzMRLjfLGu+eFpNgziaxNxOrWpZw6m0pTbjg8SPXqns0lRlvR4TWBbbr
	 pU8DEX+kzlI5SpXyyZHpOFMjryVe1etuO2kmJqb32dBoPbGgtQEgKsUBaAkTSQoo2+
	 WJBo7X+1vW9b8FkTLlz5xSLXAN9JOu7Higf6jw6UsgHAfaqL0oBMwvtttOO03QoNQy
	 EylYywyk+Hr1p7wN59CUkVNOY8e7z+2dDVs3FYsTicN5uicU65KB2/lRhCKPmR+ZIV
	 aSpaGJPcUiwgQ==
Date: Thu, 3 Jul 2025 09:19:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, neil.armstrong@linaro.org, 
	abel.vesa@linaro.org, kw@linux.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for QCS615
Message-ID: <20250703-daffy-transparent-dingo-c89faa@krzk-bin>
References: <20250702103549.712039-1-ziyue.zhang@oss.qualcomm.com>
 <20250702103549.712039-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702103549.712039-2-ziyue.zhang@oss.qualcomm.com>

On Wed, Jul 02, 2025 at 06:35:47PM +0800, Ziyue Zhang wrote:
> QCS615 pcie phy only use 5 clocks, which are aux, cfg_ahb, ref,
> ref_gen, pipe. So move "qcom,qcs615-qmp-gen3x1-pcie-phy" compatible
> from 6 clocks' list to 5 clocks' list.
> 
> Fixes: 1e889f2bd837 (dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS615 QMP PCIe PHY Gen3 x1)

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof


