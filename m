Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422AF7D9801
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0M12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0M12 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 08:27:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603DFA;
        Fri, 27 Oct 2023 05:27:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11E8C433CA;
        Fri, 27 Oct 2023 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698409645;
        bh=erg1rYgP74To6KDDM1KXYV8FQqFk+IL93d/OT4RF8Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ta10opSzgCPzK+RJbeKtJ7EMbjSh54GhTiZuuIcrhdyLroX493IECvCcpfvb7tmQG
         qk2JfMz57us1lj28G4ln6dH9FnssPpgunuDN12rQl541JYJdJL2J87Wkvyc9DyBvrm
         7fVfO7+iYSNcJSfOkcWnpglQISSkfjmlfD/P3VRyobo2OqU3tcsz0Zjh/Uhv3Fb/Uq
         IK1Q0KN3Y3cvlCHKKU70/zP6YqhdndEkKNAS4WkdynltFe0fVootg5Bg+pIi5xVlCK
         2xvXBkcDqJkOCkpPrjaENfuPjqgnmZpe2ebi1jrMhwU3z0p/S8rhl9UPtgh1VTj2/4
         prrA0FqagnZMw==
Date:   Fri, 27 Oct 2023 17:57:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/5] PCI: epf-mhi: Add support for SA8775P
Message-ID: <20231027122711.GB17527@thinkpad>
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-5-git-send-email-quic_msarkar@quicinc.com>
 <20231025075603.GD3648@thinkpad>
 <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
 <fb0647b5-67c4-4558-ac41-ee2b21446ee2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb0647b5-67c4-4558-ac41-ee2b21446ee2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 01:10:00PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10/26/23 07:30, Mrinmay Sarkar wrote:
> > 
> > On 10/25/2023 1:26 PM, Manivannan Sadhasivam wrote:
> > > On Thu, Oct 19, 2023 at 05:07:09PM +0530, Mrinmay Sarkar wrote:
> > > > Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
> > > > SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
> > > Is the PID fixed? I thought you just want to reuse the SDXxx PID in the
> > > meantime.
> > > 
> > > - Mani
> > 
> > The PID for SA8775p EP is not decided yet. So using 0x0306 PID meantime.
> If it's not decided, why should it go upstream then? Would that
> not break the hosts' expectations when the EP device is updated?
> 

No, it won't. If the device uses existing PID, then the existing host drivers
matching the PID will be used for this device. When the PID gets changed, then
the host drivers need to be updated too.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
