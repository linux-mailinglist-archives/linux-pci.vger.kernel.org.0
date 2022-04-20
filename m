Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD9508288
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbiDTHtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiDTHtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 03:49:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E559FE0
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TzUH/+KtUePJm3VvSUD9DMk4PFiOFvsYjPIzi3V1hXw=; b=v9PfnfXePcTToSeY41SSrsmoDj
        ABOpK9WsH/UzbqF//+DZrmQ06Icnk35hayR1qw02iNuSJwzNO7sHjsyLnS+m0jsvOswUtlz+w8iWe
        nKA+0zCEp12CEhXNCcuxWNMF+7nEj5Vg9dE0Of/w4sNPAzYwuS1/w13Fhd2+5Fdrl6qwGmR1gO1XK
        DPk2v9d4gmgoT/dPa0WFTtn3WzNL7XQgtFmo6EMU/lnFTaKLYas0PdVDskIbLdraYd09yilR2B3Ur
        MUwRX0cO+uCwT3p0KmHvDIGe0YaiKkWwXfJ/d47GrNYGOXMSvt8Ubn85xfz+kjJynv4D5ladUlQzi
        JUyHP3Bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh52l-007rzx-Uq; Wed, 20 Apr 2022 07:46:31 +0000
Date:   Wed, 20 Apr 2022 00:46:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <Yl+6V3pWuyRYuVV8@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <8b2735c1-4207-dc1b-45bc-33a4138b57cc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b2735c1-4207-dc1b-45bc-33a4138b57cc@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 15, 2022 at 02:29:27PM +0530, Nitin Rawat wrote:
>  1. Adding a flag notifying nvme driver about the d3 support or not - Adding
> flag to PCI bus will make it applicable to all the child devices of the
> RC/bridge and that would cause problem as this behaviour is only applicable
> for nvme device for now. Any suggestion
> 
> to avoid this?

This seems like the only actual sensible option.  Why would you want
to avoid it?
