Return-Path: <linux-pci+bounces-23717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB15A60A9A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B16919C0310
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DA618B482;
	Fri, 14 Mar 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io4iEEbG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228018632B;
	Fri, 14 Mar 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939074; cv=none; b=TcYy5alAhNLvWHQy6rx0apDjoPb71LU1bG0D1cy8fowzeJNDt/G9PC6F/aAqBQSmFBn5W0T1VdjVni8wg1Bi05ePbWxKrScuntmcdSRXZYI1eq/py4Xq0QX3ngO1vCzU0lIgKkT9dVyYIwrNp9Oca6XY7+Bw1GrTjBSeSdBYRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939074; c=relaxed/simple;
	bh=kLmVLSVYE5l3QJYFELjSs2DqsuxPPf5s9sQcfNt7eAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxa443IOZqHJ7XshCVCcVs4t0f4JRbXPIejqfvhsJY7RMLl9AQDMzsdV5sShxXT3sCLewPFfFTXHwepEnHvt6G5ml2xTvRr5Jd4EBC+nQswvXFzt+dBnQGGpbLhMFAI2dno05yDNaXb4uR1l3O2IoJjBRRY9QOXD0WTEJxIqOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io4iEEbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E7C4CEE3;
	Fri, 14 Mar 2025 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741939073;
	bh=kLmVLSVYE5l3QJYFELjSs2DqsuxPPf5s9sQcfNt7eAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Io4iEEbGYXxvd6eRGU4X19Vx0Q1/Y7eauxv65W9Ixi/Mysh60rIUlGxzMKYUQgCFu
	 g5qyDOIJJ5r4q3j6Gx3XuLzXYADzppcIkP4FPZJ5p77BKFy+PXY66PfqpI+9Kf0Wfo
	 hIb6EMmMtqOWPJNsmd+Dv5x2NTGi5YyO/zkNeULflCZSr0VY7FhkFvvrm627XEk6rS
	 Du2uo6/uH3BO8kBgjrCThMMr6Qduj+LmqHuipjBjJeYWX/a8NjiyJGQ5CWaDGgvl0z
	 ii2IICkI2hLw/caelcqp7xoAZ0JBdYMxqigr0y4SDBpsfytXXt9PULW36d66DxhC4N
	 wtMwr4qcoPRlg==
Date: Fri, 14 Mar 2025 08:57:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 1/4] dt-bindings: PCI: qcom: Add MHI registers for
 IPQ9574
Message-ID: <20250314-resolute-slim-waxbill-eaa9ee@krzk-bin>
References: <20250313080600.1719505-1-quic_varada@quicinc.com>
 <20250313080600.1719505-2-quic_varada@quicinc.com>
 <1c88f01b-4414-4f02-91ed-572a9261543a@kernel.org>
 <Z9LGti0cdg9Sj6xa@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9LGti0cdg9Sj6xa@hu-varada-blr.qualcomm.com>

On Thu, Mar 13, 2025 at 05:21:18PM +0530, Varadarajan Narayanan wrote:
> On Thu, Mar 13, 2025 at 12:01:54PM +0100, Krzysztof Kozlowski wrote:
> > On 13/03/2025 09:05, Varadarajan Narayanan wrote:
> > > Append the MHI register range to IPQ9574. This is an optional range used
> >
> > Same question, you still did not answer - does hardware have this range?
> > Which hardware has it?
> 
> Yes. All three (ipq6018, ipq8074, ipq9574) have this range.


Then explain in the commit msg that you complete the hardware
description for these SoCs.


Best regards,
Krzysztof


