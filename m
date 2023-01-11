Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7024066660E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 23:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjAKWO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 17:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjAKWOY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 17:14:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34243E45;
        Wed, 11 Jan 2023 14:14:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C748B81CD5;
        Wed, 11 Jan 2023 22:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC377C433EF;
        Wed, 11 Jan 2023 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673475261;
        bh=brVowBD7+XLa5K8t/DrjPINuNXrFSej5bIzDIj+mIFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dG3fOAFX0pDPm9wB7aarisELFuK5eWKPQ1eHhaEiS5CXGgVo8fswI+q6JmaGaJzQq
         4PW7BjrZHQnZIwDnxBabdJCo/XstfAqNrQWO9z7s3YRYf2NkTXayVJHhc9KSnR42+M
         RlRxsc9oqJFIe3aPzKNaxDrHTJan9pHD70nkp8j3ReR8MgKkDjsJrkoqw9NcilnO5f
         iO+hkJA2t7+aJOXa6/XUOo58D4nFucoDM3DMRV9pNFlfbRS6gSe/g9F825KmhJuCQo
         Up33XjlCLgLtu+/RJRoxWjvJj+m4Xu8KlOpx0wekWfREKUGu83AUKlP6ZLi+wVrRJZ
         koV0YRz1S7q8A==
Date:   Wed, 11 Jan 2023 16:14:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jian Yang <jian.yang@mediatek.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        chuanjia.liu@mediatek.com, jieyy.yang@mediatek.com,
        qizhong.cheng@mediatek.com, rex-bc.chen@mediatek.com,
        david-yh.chiu@mediatek.com
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Message-ID: <20230111221419.GA1710905@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111032542.20306-2-jian.yang@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jan 11, 2023 at 11:25:41AM +0800, Jian Yang wrote:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Make MediaTek's controller driver capable of controlling power
> supplies and reset pin of a downstream component in power-on and
> power-off flow.
> 
> Some downstream components (e.g., a WIFI chip) may need an extra
> reset other than of PERST# and their power supplies, depending on
> the requirements of platform, may need to controlled by their
> parent's driver. To meet the requirements described above, I add this
> feature to MediaTek's PCIe controller driver as a optional feature.

Is this delay (dsc-reset-msleep) specific to a device downstream from
the MediaTek controller, not to the MediaTek controller itself?  If
so, it sounds like it should be a generic value that could be used by
other drivers, too.

How do you determine the value?  If there's some PCIe spec that
determines this, please include a citation to it.  

Bjorn
