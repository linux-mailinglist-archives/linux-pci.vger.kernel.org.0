Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD807D153E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377973AbjJTRzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377976AbjJTRzk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 13:55:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6ED55;
        Fri, 20 Oct 2023 10:55:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954CFC433C7;
        Fri, 20 Oct 2023 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697824538;
        bh=6utHZ9+NrAIuuZw1d4OnIC9m1KlbuOC3s+8qq8dWbjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GE8f/aJBsQX15JtYK3XWsfMDwaNMwSWbr31ddKKB7XFNEHWDL17LaNbqM8JZipEYW
         9b1WxxIQYYKRQ9lfVKjL7GNKZnbkoAsgud9JeMXsCGdDVTHLNuY93njZCxoa/yJ9Pp
         S+lD+S2qBZXYmqfpIw933Rl+xBbEssCvOjrwqvTZW1QPGwoU3fP/Z/x8wQYu6wslMK
         Sez14bJzduxCCrvAKCwnbM0L8aBh6MsE6+fSlUcrtATvqwocGi9sdoyJ6EiMsnXDTh
         +if3gxc3gonSFzffq4Fj9lfHzRBlCgMZiHjA1UTRPR8yeS0E17uB4YCrjzTdTA4xFO
         HzmX2VJZLmJTw==
Date:   Fri, 20 Oct 2023 23:25:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 5/5] tools: PCI: Add 'B' option for test doorbell
Message-ID: <20231020175527.GD46191@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-6-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911220920.1817033-6-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 06:09:20PM -0400, Frank Li wrote:
> Add doorbell test support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  tools/pci/pcitest.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 441b542346354..215d0aa8a09fe 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -36,6 +36,7 @@ struct pci_test {
>  	bool		copy;
>  	unsigned long	size;
>  	bool		use_dma;
> +	bool		doorbell;
>  };
>  
>  static int run_test(struct pci_test *test)
> @@ -149,6 +150,15 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->doorbell) {
> +		ret = ioctl(fd, PCITEST_DOORBELL, 0);
> +		fprintf(stdout, "Push doorbell\t\t");

"Ringing doorbell on the EP".

- Mani

> +		if (ret < 0)
> +			fprintf(stdout, "TEST FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
>  	fflush(stdout);
>  	close(fd);
>  	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
> @@ -174,7 +184,7 @@ int main(int argc, char **argv)
>  	/* set default endpoint device */
>  	test->device = "/dev/pci-endpoint-test.0";
>  
> -	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
> +	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
>  	switch (c) {
>  	case 'D':
>  		test->device = optarg;
> @@ -224,6 +234,9 @@ int main(int argc, char **argv)
>  	case 'd':
>  		test->use_dma = true;
>  		continue;
> +	case 'B':
> +		test->doorbell = true;
> +		continue;
>  	case 'h':
>  	default:
>  usage:
> @@ -243,6 +256,7 @@ int main(int argc, char **argv)
>  			"\t-w			Write buffer test\n"
>  			"\t-c			Copy buffer test\n"
>  			"\t-s <size>		Size of buffer {default: 100KB}\n"
> +			"\t-B			Doorbell test\n"
>  			"\t-h			Print this help message\n",
>  			argv[0]);
>  		return -EINVAL;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
