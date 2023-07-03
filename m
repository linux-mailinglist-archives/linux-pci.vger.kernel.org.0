Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4194C745E1E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGCOFD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGCOFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 10:05:02 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 07:05:01 PDT
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1980106;
        Mon,  3 Jul 2023 07:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688392179; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SP9ImYKJXEf65WKqag/ju5y526ZfAFIBV4itRdPacBQ3+yv5KnCru8ASuO9Hlo1Gt2oK5OjGfBVUSMXqhHesfFw44l8G58ol9rDbTZs4DUmr2mNbiu8R7n5wTKI8SpMtNvhTnFheLb4J/UW25OjOE1YUX+l1vx5BFFQaQfHSCDs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1688392179; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0juxJGr0V0mWBkxuSy/zAkO1ju2c9SqaUoNVC94Ta+g=; 
        b=DX6QQuBCyOLO33f2JL3SPON+PDyKnDqY1eJlK7uslPKmFb4TRsfiJgmyoGAQztmM7A8PKEZK+FLdZdB8gsIsKBIY7lsV6kcJNwhVBuvbkVjUmHLbEUBwrCT7wWyc8/wZWC1zStk5lUGlH6HoxgGCe+XO8Lghe/GrXoaadX9RSFw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1688392178;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=0juxJGr0V0mWBkxuSy/zAkO1ju2c9SqaUoNVC94Ta+g=;
        b=HWnuovJb6yqvdgTAK2CNyPNMuAPlm0fFmH8WjjDVWS0zulM3dFFROXLQSFR/CqSV
        SmRDdJwch6aB7hRBeuhgl35fz65Jn4i+LDo+6X6IBx8lnPlgfa1Pq9/V20UT1owcSFJ
        WugwavBR6h6CxjQqQP3VeKrrITPPXzcFwAyMXimw=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1688392177737939.3774690465508; Mon, 3 Jul 2023 06:49:37 -0700 (PDT)
Date:   Mon, 03 Jul 2023 21:49:37 +0800
From:   Li Chen <me@linux.beauty>
To:     "Achal Verma" <a-verma1@ti.com>
Cc:     "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tom Joseph" <tjoseph@cadence.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Krzysztof Wilczy_ski" <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-omap" <linux-omap@vger.kernel.org>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1891c041807.fea67a55448140.3454059194195387266@linux.beauty>
In-Reply-To: <20230703112914.68806-1-a-verma1@ti.com>
References: <20230703112914.68806-1-a-verma1@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix delay before PERST# deassert
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Achal,
 ---- On Mon, 03 Jul 2023 19:29:14 +0800  Achal Verma  wrote --- 
 > As per the PCIe Card Electromechanical specification REV. 3.0, PERST#
 > signal should be de-asserted after minimum 100ms from the time power-rails
 > become stable. Current delay of 100us is observed to be not enough on some
 > custom platform implemented using TI's K3 SOCs.
 > 
 > So, to ensure 100ms delay to give sufficient time for power-rails and
 > refclk to become stable, change delay from 100us to 100ms.

What problems could arise if the delay is too small? Would some endpoints not be able to detect it?

Regards,
Li
