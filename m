Return-Path: <linux-pci+bounces-2205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0AC82ED43
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF49B2286B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D01A58C;
	Tue, 16 Jan 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9RGWdNQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01918EB1;
	Tue, 16 Jan 2024 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A89C43390;
	Tue, 16 Jan 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402828;
	bh=244YkxZhJi5dUXH5mXoHQmSnozi6cbnZ7eQbDKl9ods=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9RGWdNQgacb/mIk0KHAJYrvzxEQZp56hom5g/aJcB401/lbWnl7VbP6t7gVc4Y55
	 0m+EeRMEiteUyO6kz0lOqLTnCbIVY3djGQ72y/CiEVS4I3KmoHlystvtjHuvmoO1Qq
	 eAkws13heL2yeXD9qAFT5mSrV13iS7gwFCPXYhWHFNS6pwfZ6JEU2e8AATJ97luSSC
	 yiQ1B2SQ0BsaexERUGMBfZmfeWQb1ApITTo4RT0hzg/etZa+d1hk8jg9ZpIuWeKQaz
	 gVVzRTwDE20YP+XHd9cveUs358k2bjVjy8SR27pposRFmzBHGXvumrr3eJYeI9Rg7N
	 8a2zg4f/KYw4A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPhBH-0005aT-0o;
	Tue, 16 Jan 2024 12:00:31 +0100
Date: Tue, 16 Jan 2024 12:00:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <ZaZhz4oqNbz4evLX@hovoldconsulting.com>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com>
 <CAA8EJpqwOfeS-QpLVvYGf0jmTVxiT02POwK+9tkN03Cr4DgL+g@mail.gmail.com>
 <da1945ce-7e34-6ad5-7b9b-478fcbd4a2c6@quicinc.com>
 <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>

Please, people, remember to trim unnecessary context from your replies
before hitting send!

This thread is barely readable currently, and leaving all context in
place also makes revisiting threads using the lore web interface a pain.

Johan

