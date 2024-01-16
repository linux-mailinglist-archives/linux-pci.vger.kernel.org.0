Return-Path: <linux-pci+bounces-2202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734BB82ECEE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058A3282759
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119018C16;
	Tue, 16 Jan 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfqpe7nz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518617BBC;
	Tue, 16 Jan 2024 10:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1296AC43399;
	Tue, 16 Jan 2024 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705401965;
	bh=mbJ1c5G3Vv08PsHhe4Zo7OUyXuKmAEsQWpRmgYggN64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mfqpe7nz66qoUzp5GJeBswJTc4VxZiZH5Xbho3cjzMjqQfv+8blfoDXbXrNaZc8ln
	 cCFSjMZ+YpuwFmfIf4Lxr8fx5a2PN+KztapO4FFzk0N9GPMQGvu4VGKFe3TPfcTJ0D
	 /rITwa2Z+EPytNi84txlH5Rv4Ej24TcsWbZp0Xo88V1q6SS5ONKP+BlzAF8tny8dJp
	 bWp5adKnChYgZoM1bDnXB8U4HTEs+hdOIgTRT3+K1bIgXnDwS7LiRXq0WmhSBJHS/o
	 HZPYNbFPB/P+6rZ7GcQjNL4mQnPYoz7g8CJlmefGDLYrqbenwG8wQO4D7JOfRp7orW
	 Tr87DyYUOAgBg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPgxL-0005YC-1P;
	Tue, 16 Jan 2024 11:46:07 +0100
Date: Tue, 16 Jan 2024 11:46:07 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Message-ID: <ZaZeb8YysChzT3L1@hovoldconsulting.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <ZaFhzOCTpZYlAh60@hovoldconsulting.com>
 <1a3aeab6-740b-ebcc-e934-6153a4292151@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3aeab6-740b-ebcc-e934-6153a4292151@quicinc.com>

On Tue, Jan 16, 2024 at 10:34:22AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/12/2024 9:29 PM, Johan Hovold wrote:
> > On Fri, Jan 12, 2024 at 07:52:02PM +0530, Krishna chaitanya chundru wrote:
> >> CPU-PCIe path consits for registers PCIe BAR space, config space.
> > 
> > consits?
> > 
> >> As there is less access on this path compared to pcie to mem path
> >> add minimum vote i.e GEN1x1 bandwidth always.
> > 
> > gen1 bandwidth can't be right.

> There is no recommended value we need vote for this path, as there is
> BAR and config space in this path we are voting for GEN1x1.

I can see that, but that does not explain why you used those seemingly
arbitrary numbers or why you think that's correct.

> Please suggest a recommended value for this path if the GEN1x1 is high.

No, you submitted the patch and you work for Qualcomm. You need to
figure out what the value should be. All I can say is that the gen1
value is likely not correct and therefore confusing.

> >> In suspend remove the cpu vote after register space access is done.
> >>
> >> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
> >> cc: stable@vger.kernel.org
> > 
> > This does not look like a fix so drop the above.
> > 
> > The commit you refer to explicitly left this path unconfigured for now
> > and only added support for the configuring the mem path as needed on
> > sc8280xp which otherwise would crash.

> Without this path vote BAR and config space can result NOC timeout
> errors, we are surviving because of other driver vote for this path.
> For that reason we added a fix tag.

Ok, then mention that in the commit message so that it becomes more
clear why this is needed and whether this should be considered a fix. As
it stands, the commit message makes this look like a new feature.

And the above Fixes tag is incorrect either way as that commit did not
introduce any issue.

Johan

