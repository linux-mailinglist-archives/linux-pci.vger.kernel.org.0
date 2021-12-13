Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C73473866
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 00:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhLMXYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 18:24:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48554 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhLMXYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 18:24:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E933B816E1;
        Mon, 13 Dec 2021 23:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB36C34601;
        Mon, 13 Dec 2021 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639437857;
        bh=A9pKYsIk8sVgWhuPxxwl6CXmwAOIQO9QyUcOm4pfpSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fI/qqDW72TRDXIw9jcT0c5ByYhyLm7Wlw22TzOKpb9YX8lNF8qHEWcs9pjP9oKegc
         ZZu9byNHqjd27HrCqz6iNi+gBLEswNRHbb5Ds29H99f/RtsYSA1dPkHb/eqT0KfIDb
         ugnclVHE205t21hoDIJMrIkqSRO1PzyPtjkyVifsv92oGqGLdYeuJgpzugQ7hGJW78
         sCeVDoWLX+JBq0lrq8yvUEOJjqo0Ee81o1LHdcXm/2haSs5b0zPFZ00VFcLH0ty7Z3
         Yg4S98c3MMNi0R5912j6QrJPqbms/kPBGyL1OMJvc04IAQ9hhzafi2Dy5Baoqm8Kf/
         gGYkjsT4wPkqg==
Date:   Mon, 13 Dec 2021 17:24:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 04/10] PCI: qcom: Remove redundancy between qcom_pcie
 and qcom_pcie_cfg
Message-ID: <20211213232416.GA554939@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211021758.1712299-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 11, 2021 at 05:17:52AM +0300, Dmitry Baryshkov wrote:
> In preparation to adding more flags to configuration data, use struct
> qcom_pcie_cfg directly inside struct qcom_pcie, rather than duplicating
> all its fields. This would save us from the boilerplate code that just
> copies flags values from one sruct to another one.

s/flags values/flag values/
s/sruct/struct/
