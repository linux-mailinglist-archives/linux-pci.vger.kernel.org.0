Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4618D85E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTT0F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 15:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTT0F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 15:26:05 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204B52070A;
        Fri, 20 Mar 2020 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584732364;
        bh=/rTRPrDhJPt4afzfgd0cuC2zrxLd35n21OmKayC8W68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YgZZVxxJ9LAvCPtnja5yPtD+z0QxRzJg+mZhLe3MxWZntMk2qTyLe3hSemIxHX3Xe
         LMPCDV2Aqaw8G3QyClqjl+tm5pn9SG6fagISApYGJUszFoclDQOlU+Il9a6mjGjyrI
         7TncXVBleNOp7LEkTBmmf63cI1T4Dnn7r3GMr57A=
Date:   Fri, 20 Mar 2020 14:26:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] pcie: qcom: Programming the PCIE iATU for IPQ806x
Message-ID: <20200320192602.GA247248@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-9-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/Programming/Program/

Capitalize IPQ806x consistently (other patches mention "ipq806x").

On Fri, Mar 20, 2020 at 07:34:51PM +0100, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Resolved PCIE EP detection errors caused due to missing iATU programming.

s/Resolved/Resolve/
s/PCIE/PCIe/

Is this a bug fix?  If so, can you cite the commit that introduced the
bug?  This is useful when backporting fixes.  Same question applies to
the other patches as well.
