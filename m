Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7997D78C8A2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjH2Pbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjH2PbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 11:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891C1AA
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 08:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6474C62500
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 15:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AA1C433C8;
        Tue, 29 Aug 2023 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693323070;
        bh=Mh+0y0yvc2IN0GEB+tS5u7wKkJo7kMHFUG22ug+/wpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAJihCfAHQ72atMlN8qu8/0P9QTeguvBD1yPx5jidJitAGxPWCDc0jdzM3cylztuz
         4XR/x7wbQxP+7z8mUWLXsCGwGx4NLqgjhEy4Pp9q8I15klYet0CaOEpDclKfcGa1wD
         HXxiFP0LaW0sxtQwM9pmKa1nRjyI4BnnOoAj6pChyOHbpBdhqT+TAtjpVCBZDrzloO
         J5kLQGBE9DfzSoGMQ6rlbtsVsoTsfSmFvIPxbvFc3y9dUIXnXHHN4gCCGWVs6oyJ5A
         lWTJ4wMlYV9L3PnFyUxqERFOJDabkttWl2R3jC+7UQRFD8b1xDXQc+3mX2JdbgNdSI
         MWQWOWjKzEH4A==
Date:   Wed, 30 Aug 2023 00:31:09 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [pci:controller/qcom-ep 3/3]
 drivers/pci/controller/dwc/pcie-qcom-ep.c:198: warning: Function parameter
 or member 'icc_mem' not described in 'qcom_pcie_ep'
Message-ID: <20230829153109.GA2138716@rocinante>
References: <202308292252.HNCCTM4u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308292252.HNCCTM4u-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]
> >> drivers/pci/controller/dwc/pcie-qcom-ep.c:198: warning: Function parameter or member 'icc_mem' not described in 'qcom_pcie_ep'

I took care of this on Krishna's behalf.

	Krzysztof
