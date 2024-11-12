Return-Path: <linux-pci+bounces-16614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F179C6592
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 00:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC16B2BD0A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456D21B441;
	Tue, 12 Nov 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEjAgXL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F7213135;
	Tue, 12 Nov 2024 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454571; cv=none; b=aAsiw7JHU4QB2AjvpG+TGakgXkSU+axO27quPxG5ykNgpYNymqkIYekOpBtBWuxQe4ASAJohUadAKbzpDQfp2RD4DhHBNCcodNuSISWVCNUyl5CK+TRJWXpa07SSgo0/HrNXE2i/c+Bpn7Om5zQXerYsVI8Wz3ySpZa1hY0ouHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454571; c=relaxed/simple;
	bh=/TPokpxxqBCSxODbElmymv5J7dT7y7+x2mJG/b+XzwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R2/em809UOQicpHizG1k7YDy6x4HQ5+eVDO3/i+CPlXg0dEYDYIv9XeTYlSIQmbnrANgIF9gzfSC2mILXo1IrKD9tS3rV3uob3UAQBVkZ/60QxAZXNhZiascBohKY0KJSwwOLWQ9EQz3B8nRWDFWMi6SvdOzDfAFkgcppsbkkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEjAgXL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F48C4CECD;
	Tue, 12 Nov 2024 23:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731454570;
	bh=/TPokpxxqBCSxODbElmymv5J7dT7y7+x2mJG/b+XzwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pEjAgXL/Bx0cISZKG47p5G2Va0oSc+IwAICmznCc8MzhXPJ/+dOBIHMbxK1B8q8F1
	 xat9QYWUKd1xDP9/UdG56AGMedrSu1Zf5u8qjSRW9etlMxOO52sT7rfgvJ16Z//bq0
	 ch3u1yAOvSBVBhLTdjIrL9WNp5lzPiKfbfzSFTBbCY/qksBPdEiCkfzVkj194IlalP
	 WUobmALNtKBNAXeqS4ZvbE3SMEwfenBPn7/zPYAQuQR7YenCsm3BMLwc+o8HmdVrD/
	 Z6fXEy+GH3dwMxuRqKWGhuNhtxVskyN2qMvApIUeYVDaAD73VsQGoUacwD2QNEg1ry
	 47f3MWjxkTk8Q==
Date: Tue, 12 Nov 2024 17:36:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Message-ID: <20241112233609.GA1868317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-5-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:37PM +0530, Krishna chaitanya chundru wrote:
> For the switches like QPS615 which needs to configure it before
> the PCIe link is established.
> 
> If the link is up, the boatloader might powered and configured the
> endpoint/switch already. In that case don't touch PCIe link else
> assert the PERST# and disable LTSSM bit so that PCIe controller
> will not participate in the link training as part of host_stop_link().

s/boatloader/bootloader/
s/might powered/might have powered/ ?

> De-assert the PERST# and enable LTSSM bit back in host_start_link().
> 
> Introduce ltssm_disable function op to stop the link training.

