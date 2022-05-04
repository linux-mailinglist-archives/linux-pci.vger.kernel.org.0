Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94451A1AC
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiEDOF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiEDOF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 10:05:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F6928992
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 07:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B51CB82584
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 14:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A377C385A4;
        Wed,  4 May 2022 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651672939;
        bh=8OmQD6Kfg6qjSQG3tvPXnCKfLVYwuf8lIPx/xw1ajqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iZ7+meg6fUEK5HFSsGZp6nhljFrY9h/Iw4h4/MCZU6DxQbMvLfi4k6PLfzSzLNQjQ
         DXU1KXwQf1PoxJDjCT/abaIkRlDTfdojF+7WfMEaZmaWPIRq1ajOCyWKKmU326CV3x
         ymgcpnjRxU4g/FBI6y1d4oHaxxlC5lo3bgtgmRzOhJR1Kq9c8j6R0rXKVkyNwS2TX8
         YX4jnq+h0CHuCvU9Wt4t8wTC+bte2wWd9H3p6cSYvuyzmkkoRdLnOajplCeNM3TSyx
         5We+meE69dCst3H+iKYN2zXwWRhpOAH0Kr3ayQRvNkp6T99iiHrQoicDuJqEHQqJKL
         hkWtEn7pHOvaA==
Date:   Wed, 4 May 2022 16:02:14 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/18] PCI: aardvark: Run link training in separate
 worker
Message-ID: <20220504160214.01e91fd4@thinkpad>
In-Reply-To: <20220413091603.GA19821@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
        <20220220193346.23789-18-kabel@kernel.org>
        <20220412152524.GB20749@lpieralisi>
        <20220412175541.gnrynogn3s2llari@pali>
        <20220413091603.GA19821@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Apr 2022 10:16:03 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> 
> It is fine by me - I will consider other patches in the series.
> 
> Lorenzo

Hello Lorenzo,

did you have time to look into the other patches?

Thanks,

Marek
