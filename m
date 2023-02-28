Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E346A59E5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 14:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjB1NU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjB1NU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 08:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A577D2E817;
        Tue, 28 Feb 2023 05:20:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3602961087;
        Tue, 28 Feb 2023 13:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C189DC433EF;
        Tue, 28 Feb 2023 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677590455;
        bh=7JKAP1dx+7Ok1mnFRScROkFxj3hLAmTAiCcQtf73Uv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEr4ORwyCILo5xRpeBLrxMIgY9JJrZFPbXBEwP+DIE/kd/y5W+lPvkdu6eCboGpT5
         SN3Cs37H8z5qbGiUbsubLJWTLJGQeQVBqbadLfqw31DkR75B8F9Td5zWHusVvHQW49
         p+xW4XlsqEBqi+k/1o9RDknP6pqiHxywGD7r3v7EfD2uJ/uN/FcDXnQcvJP48UHUvl
         TDgpbSxXD0ltVdUOZQEd3eJc5NUGYExUDkL6pKKefNeGdgMdVQQi71GwPhcHCke3fh
         aIUygJyMsvNjZ4pMGxDspibRO78wxOAyGF/PyY22MVKQLVejmsYwWhXC4HWZUCDWqv
         3bJPC+BZBWUZw==
Date:   Tue, 28 Feb 2023 18:50:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robert Marko <robimarko@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, bhelgaas@google.com,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
Message-ID: <20230228132043.GC4839@thinkpad>
References: <20230113164449.906002-1-robimarko@gmail.com>
 <20230113164449.906002-8-robimarko@gmail.com>
 <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com>
 <CAOX2RU5Y642gWMSaK6fJ2tz=9N2AO-1fFhL5=wfLeTWWkVjz7Q@mail.gmail.com>
 <968c056c-74f9-4a8f-b662-51f60df93694@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <968c056c-74f9-4a8f-b662-51f60df93694@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 02, 2023 at 10:42:15AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 2, 2023, at 10:16, Robert Marko wrote:
> > On Mon, 30 Jan 2023 at 18:11, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Fri, Jan 13, 2023, at 17:44, Robert Marko wrote:
> >
> > As pointed out in the commit description, the ranges property was copied
> > from the QCA-s downstream 5.4 kernel [1] as I dont have any documentation
> > on the SoC.
> >
> > I have runtime tested this on Xiaomi AX3600 which has a QCA9889 card on the
> > Gen3 PCIe port, and on Xiaomi AX9000 which has QCA9889 on Gen2 port
> > and QCN9074 on the Gen3 port and they are working fine.
> 
> Neither of those use I/O ports though, nor does any other sensible
> device that was made in the past decade.
> 
> The compatible string tells me that this is a designware pcie block,
> so I think driver actually sets up the mapping based on the ranges
> property in DT in dw_pcie_iatu_detect() and dw_pcie_iatu_setup(),
> rather than the mapping being determined by hardware or firmware
> in advance.
> 
> Not sure about the general policy we have for this case, maybe the
> pci controller or pci-dwc maintainers have an idea here. I would
> think it's better to either have no I/O ranges in DT or have
> sensible ones than ones that are clearly bogus, if the controller
> is able to set up the ranges.
> 

Just happen to see this thread and I agree that the I/O port range is indeeed
bogus. This is due to the fact that no one tested I/O range with a compatible
device.

I'm not sure about the PCI policy though but we should fix the mapping across
all SoCs. I will send out a series for that.

Thanks for spotting, Arnd!

- Mani

>      Arnd

-- 
மணிவண்ணன் சதாசிவம்
