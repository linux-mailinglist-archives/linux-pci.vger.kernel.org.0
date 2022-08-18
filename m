Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B4598CEC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHRTwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbiHRTwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 15:52:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9279A97C;
        Thu, 18 Aug 2022 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=dObx+PX0Vk5nSc7FO3kmhNywModBXG19A8zPdZ1mbds=; b=NK
        d3kTDwHhqaqWDIi9SMngVNaC8RpDZq8nHrvx8PQTphLK0ELke91sw1UmM+Gi6pDCMTJT1bGb39Ov/
        69Ne+hvolkdKEymB7Tif7rmP6+pCi+YaqO4F0FbPhwbz6GU37NTrdhDR6u8nhyJZn2auPVxQKAflp
        j2627upYfZ+KZpc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOlYa-00DpsC-O9; Thu, 18 Aug 2022 21:51:56 +0200
Date:   Thu, 18 Aug 2022 21:51:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: dts: kirkwood: Add definitions for PCIe error
 interrupts
Message-ID: <Yv6YXCwRCSa5i5WM@lunn.ch>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817230036.817-4-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 01:00:35AM +0200, Pali Rohár wrote:
> First PCIe controller on Kirkwood SoC reports error interrupt via IRQ 44
> and second PCIe controller via IRQ 45.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
