Return-Path: <linux-pci+bounces-6569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955D8AE670
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BE6B22A20
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB8113541B;
	Tue, 23 Apr 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpKUFJiI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F912E1EF;
	Tue, 23 Apr 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875933; cv=none; b=V9ZuSRGbC4/HqtvPtVnbZ/w4Qt2HrZuT6N0hvnVIEmklvXDpzH0FP9R6/eN3EKg5HF6HsWPXI0ZuGhVsI8o+jgUOr9mWo5hzjzZcJlTQakwcDS0ORAkoicq24uvHyl6uPcYhw2cQYHl1TANKp1N97eYuiHVeZ952dNL3W1vG90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875933; c=relaxed/simple;
	bh=+cXiwTbxFmfiSsQO21Adm9RSvK/3tEUU0QEneBBOX70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMA5saaKFKcuPxFEO7+U2rqimf3T1XYHjMTSKJZgMiMlnijP9/V/G4izWXfcNmy5/ycmCO3WYyDh29xSbU4nPS7tPOMVYSmWdAKpEDzM4sf+aByU6AmqU/oKl77hSjC06NyB+hrvNWn4uuxYSRZmYlHuxznYnTV8AIqr/6rli8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpKUFJiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B64AC116B1;
	Tue, 23 Apr 2024 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713875932;
	bh=+cXiwTbxFmfiSsQO21Adm9RSvK/3tEUU0QEneBBOX70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpKUFJiIg8iLilLGVtbduWQebSgX9U/D2FgvydndfzBLm9spskITcBjNtTxVG/Gpm
	 XbLH7kLJJqXOJDoEmSY3fTfB2qy3dDiZCXjfvKnyjPsLGmmtn8kFvb5SuCSu4h+/vC
	 SGhpydeagU0louQl4VetJfuyjGbrzOeSa3iAfjsJrK25+9XaOEFdqHdGF8rwt7fGb+
	 142bvCoSGBKlTZByQGf/BulrwuMcegszSwNikANTdo6aTUIHNwwUdcSuffkxFGLZOc
	 WIkY0zKC3o9jNPzig34V7fQcqTDK2SS+BJs5VLYvetlnAQSKOyAffltLIj67pHXgwt
	 RTMtcjiQt9ZTw==
Date: Tue, 23 Apr 2024 07:38:50 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Message-ID: <20240423123850.GA4105016-robh@kernel.org>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-2-sean.anderson@linux.dev>
 <171382130333.1986303.15938018699322126426.robh@kernel.org>
 <173a7bb2-5473-4c1b-b3dd-ef776e63ac7a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173a7bb2-5473-4c1b-b3dd-ef776e63ac7a@linux.dev>

On Mon, Apr 22, 2024 at 05:30:06PM -0400, Sean Anderson wrote:
> On 4/22/24 17:28, Rob Herring wrote:
> > 
> > On Mon, 22 Apr 2024 15:58:58 -0400, Sean Anderson wrote:
> >> Add phys properties so Linux can power-on/configure the GTR
> >> transcievers.
> >> 
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> ---
> >> 
> >>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >> 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml: properties:phy-names: {'maxItems': 4, 'items': [{'pattern': '^pcie-phy[0-3]$'}]} should not be valid under {'required': ['maxItems']}
> > 	hint: "maxItems" is not needed with an "items" list
> > 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240422195904.3591683-2-sean.anderson@linux.dev
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit after running the above command yourself. Note
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your schema.
> > 
> 
> This warning is invalid, since I am using pattern with items.

It is valid. You need to make 'items' a schema not a list (i.e. drop the 
'-').

Rob

