Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A964624653
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiKJPuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKJPug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:50:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BC1F3;
        Thu, 10 Nov 2022 07:50:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9836B8222F;
        Thu, 10 Nov 2022 15:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B148BC433D6;
        Thu, 10 Nov 2022 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668095432;
        bh=AVIbJAj0HZBSpbVNW3OVQzARVaxH+jV65cAFA+y5sMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHuIzmyYRlYUEBWTTxN2t8Q1wDHyxNQgAhkMJHvo5eQt7sAfP67S+haQ2h9PXOXl6
         S84pNH9I2qvIxUHGpc7373FuC68b2U4WNeKdsCJY6RenWzOiXBXq3srne1aRRSmHt0
         vnsKo/i5scDZP4VLgdsyDz8edSXkkq6XyfT1VV5IzG4JCMXPZjRBfHEnnFMZZtOJxa
         CLJ2xZJ3PctSEptrfu8Pk0KU+hivYO5q/s1GndMFrMASJS3OIc2tMwR6hLUrWIZ6Kw
         gg+A958GKVYll2UD91MOj5fecQs89gtrf668wNFFdSr32g1kgHWEFxrYLbh8q2w6pQ
         aI9b5OGix0riA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     robh+dt@kernel.org, bhelgaas@google.com,
        Matt Ranostay <mranostay@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, nm@ti.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: Add host mode device-id for j721s2 platform
Date:   Thu, 10 Nov 2022 16:50:25 +0100
Message-Id: <166809540787.145264.10097289668370435175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028091716.21414-1-mranostay@ti.com>
References: <20221028091716.21414-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 28 Oct 2022 02:17:16 -0700, Matt Ranostay wrote:
> Add unique device-id of 0xb013 for j721s2 platform to oneOf field.
> 
> 

Applied to pci/dt, thanks!

[1/1] dt-bindings: PCI: Add host mode device-id for j721s2 platform
      https://git.kernel.org/lpieralisi/pci/c/72f542ac4f39

Thanks,
Lorenzo
