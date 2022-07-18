Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE8577F73
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiGRKSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiGRKST (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 06:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15651C906;
        Mon, 18 Jul 2022 03:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BBC860DE9;
        Mon, 18 Jul 2022 10:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927FFC341C0;
        Mon, 18 Jul 2022 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658139497;
        bh=h79OFukJERJpHUHGqLQ5gkpECc0RLNV6RnpIUFe0S5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kesXvsM0/CCvD6AHRluFa8oXOEfFSbQbsSHqNhDNtaCXlWv1S3M7nzGMu2WAj6lGP
         JwPAgiGtF/dBUgDnq+x+Xtc+GcLUCclwtRumX8knhjcPDpZugiElP9chKqE1dLHKlt
         B0qISQgcluiu6Eov4wvoc/VZ60ZJzP+RwqN/YoCm9qBsAfO+nj1Pt+EFkVhW2WWp/f
         hewKgd5RhOGk3v17a0p8QUevtkvP2g0oQke0ouiyy9LCfr7d1ixfkVc7fIKCNsLEZd
         yTfBmj2cx4HEy1/woCOrNZ4QkqCuC9reiRDUv36QTsIMNEqk3iFDppmFRUd9ahnpl1
         xVuR3H32SmZpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oDNpL-0004jf-2j; Mon, 18 Jul 2022 12:18:11 +0200
Date:   Mon, 18 Jul 2022 12:18:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Message-ID: <YtUzY9eYM0uhT3jj@hovoldconsulting.com>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <aa11b2ec-7196-7423-151c-1797966d0cd2@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa11b2ec-7196-7423-151c-1797966d0cd2@mm-sol.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 10:49:40AM +0300, Stanimir Varbanov wrote:
> Hi Johan,
> 
> Thank you for your work, especially for for the last three patches ;-)
> 
> On 7/14/22 10:13, Johan Hovold wrote:
> > This series adds support for the PCIe controllers found on SC8280XP and
> > SA8540P.
> > 
> > Included are also three patches that clean up the way the driver handles
> > different IP revisions (e.g. by modelling optional clocks as being truly
> > optional).

> For the whole set:
> 
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

Thanks for the ack.

Could you take a look at Dmitry's MSI series that this series depends on
as well?

I saw you acking the binding, but not the rest of the series it seems:

	https://lore.kernel.org/all/3f9e1c18-bc61-8690-5427-ba8dc5fad7ad@mm-sol.com/

Johan
