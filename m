Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7C4A7609
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbiBBQgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiBBQgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 11:36:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115DC061714;
        Wed,  2 Feb 2022 08:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF406171B;
        Wed,  2 Feb 2022 16:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB5BC004E1;
        Wed,  2 Feb 2022 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643819783;
        bh=NpTl53ki0JoX6PQMusZWHm1sU34zPNG6sMVDbfk2CUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F/uLFrpBYOQKqAJ8lLgP1fd0QurQIyaN/3Cd5iNTCpNO16yuARBut1reAXCtQC7r+
         Et7lsLmruheFwIkt0eUJvqX+s20K4IjGE1pDY7ImjvH4ktXIg3i+PFcoxpSdLZmbBZ
         iwbRk/1B1Kem3EuJpMaXb1RGxBVlWF+kYit8Ea5hnBbYQOfJ1kpFyifQHLMF0OZvx8
         dxeT0c5VWuHajBGCxCAmCNDlS4WNmyDebjXiJIIAt+NxZtor5YlIGamcR3dTdIhN8F
         Azmje56r+qfcfntLAIa9+yOjF+8vS1x1vShPGTorSe8MKiTWNQ7OpStpEkEpeP0Zr4
         KJGEw0ZGNr54A==
Date:   Wed, 2 Feb 2022 10:36:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Subject: Re: [PATCH] PCI: kirin: Fix kirin960-pcie probe failure issue
Message-ID: <20220202163622.GA18307@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202162659.GA12603@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 02, 2022 at 10:26:59AM -0600, Bjorn Helgaas wrote:
> [+cc Fan]
> 
> If you're fixing a previous commit, please cc the author of that
> commit.

Sorry, I missed the fact that you already *did* cc Fan.
