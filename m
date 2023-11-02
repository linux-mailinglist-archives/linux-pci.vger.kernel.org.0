Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC77DF958
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbjKBR73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377191AbjKBR65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 13:58:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED5D48;
        Thu,  2 Nov 2023 10:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01A2C433C8;
        Thu,  2 Nov 2023 17:58:29 +0000 (UTC)
Date:   Thu, 2 Nov 2023 23:28:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, aisheng.dong@nxp.com,
        bhelgaas@google.com, devicetree@vger.kernel.org,
        festevam@gmail.com, imx@lists.linux.dev, jdmason@kudzu.us,
        kernel@pengutronix.de, kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 4/5] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <20231102175820.GG20943@thinkpad>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <20230911220920.1817033-5-Frank.Li@nxp.com>
 <20231020175304.GC46191@thinkpad>
 <20231020180139.GE46191@thinkpad>
 <ZTLBxvM/qNGw/FLd@lizhi-Precision-Tower-5810>
 <20231020182643.GG46191@thinkpad>
 <ZT/2/SSoS4azNJnb@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZT/2/SSoS4azNJnb@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30, 2023 at 02:33:33PM -0400, Frank Li wrote:
> On Fri, Oct 20, 2023 at 11:56:43PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Oct 20, 2023 at 02:07:02PM -0400, Frank Li wrote:
> > > On Fri, Oct 20, 2023 at 11:31:39PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Oct 20, 2023 at 11:23:04PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Sep 11, 2023 at 06:09:19PM -0400, Frank Li wrote:
> > > > > > Using bit 0..7 of magic as version number in pci_endpoint_test struct to
> > > > > > support older driver versions. Save to 'version' field of struct
> > > > > > pci_endpoint_test to prevent reading non-existent address.
> > > > > > 
> > > > > 
> > > > > Since both drivers are in the kernel, I don't see a necessity to maintain
> > > > > compatibility. Does it make sense to load drivers of previous kernel revision
> > > > > with a new kernel?
> > > > > 
> > > > 
> > > > Shoot... Sorry, I completely forgot that one is EP and another is host. Yes, we
> > > > do need to maintain compatibility.
> > > > 
> > > > But can't we use the doorbell register contents to determine that?
> > > 
> > > Doorbell register is not exist at old EP driver. If old EP driver register
> > > size is 64Byte,  doorbell register is 64 - 68.
> > >
> > 
> > Yes, I know!
> >  
> > > Read unexisted, or unmapped space will cause kernel dump or other side
> > > effects.
> > > 
> > 
> > For sure it won't be unmapped as the BAR0 size is 512B. I thought we could infer
> > something from the uninitialized registers. I need to think about other options.
> > But changing the semantics of MAGIC register is a no-go.
> 
> @Mani:
> 
> Any other options? I plan respin these patches soon
> 

Nothing looks feasible to me. Kishon, any suggestion from your side?

In the worst case, I'd suggest to show a disclaimer that it is not compatible
with endpoints supporting older kernel revision and proceed. But let's wait for
Kishon.

- Mani

> Frank
> 
> > 
> > - Mani
> > 
> > > Frank
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > > > Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> > > > > > PCIE_ENDPOINT_TEST_DB_DATA.
> > > > > > 
> > > > > 
> > > > > This patch is not adding these registers and not this driver also. So this
> > > > > statement is wrong.
> > > > > 
> > > > > > Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
> > > > > > PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for endpoint
> > > > > > feedback.
> > > > > > 
> > > > > 
> > > > > You can reuse a part of the commit description I suggested for previous patch.
> > > > > 
> > > > > Rest looks good to me.
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >  drivers/misc/pci_endpoint_test.c | 48 ++++++++++++++++++++++++++++++++
> > > > > >  include/uapi/linux/pcitest.h     |  1 +
> > > > > >  2 files changed, 49 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > > > > index ed4d0ef5e5c31..ed0b025132d17 100644
> > > > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > > > @@ -33,6 +33,8 @@
> > > > > >  #define IRQ_TYPE_MSIX				2
> > > > > >  
> > > > > >  #define PCI_ENDPOINT_TEST_MAGIC			0x0
> > > > > > +#define PCI_MAGIC_VERSION_MASK			GENMASK(7, 0)
> > > > > > +#define PCI_ENDPOINT_TEST_V1			0x1
> > > > > >  
> > > > > >  #define PCI_ENDPOINT_TEST_COMMAND		0x4
> > > > > >  #define COMMAND_RAISE_LEGACY_IRQ		BIT(0)
> > > > > > @@ -52,6 +54,7 @@
> > > > > >  #define STATUS_IRQ_RAISED			BIT(6)
> > > > > >  #define STATUS_SRC_ADDR_INVALID			BIT(7)
> > > > > >  #define STATUS_DST_ADDR_INVALID			BIT(8)
> > > > > > +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> > > > > >  
> > > > > >  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> > > > > >  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > > > > > @@ -66,7 +69,12 @@
> > > > > >  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
> > > > > >  
> > > > > >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > > > > > +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> > > > > > +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> > > > > > +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> > > > > > +
> > > > > >  #define FLAG_USE_DMA				BIT(0)
> > > > > > +#define FLAG_SUPPORT_DOORBELL			BIT(1)
> > > > > >  
> > > > > >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > > > > >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > > > > > @@ -102,6 +110,7 @@ enum pci_barno {
> > > > > >  	BAR_3,
> > > > > >  	BAR_4,
> > > > > >  	BAR_5,
> > > > > > +	NO_BAR = -1,
> > > > > >  };
> > > > > >  
> > > > > >  struct pci_endpoint_test {
> > > > > > @@ -118,6 +127,7 @@ struct pci_endpoint_test {
> > > > > >  	enum pci_barno test_reg_bar;
> > > > > >  	size_t alignment;
> > > > > >  	const char *name;
> > > > > > +	u8 version;
> > > > > >  };
> > > > > >  
> > > > > >  struct pci_endpoint_test_data {
> > > > > > @@ -713,6 +723,38 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> > > > > >  	return false;
> > > > > >  }
> > > > > >  
> > > > > > +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> > > > > > +{
> > > > > > +	enum pci_barno bar;
> > > > > > +	u32 data, status;
> > > > > > +	u32 addr;
> > > > > > +
> > > > > > +	if (test->version < PCI_ENDPOINT_TEST_V1)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > > > > +	if (bar == NO_BAR)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> > > > > > +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> > > > > > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > > > > > +
> > > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > > > > > +
> > > > > > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> > > > > > +	pci_endpoint_test_bar_writel(test, bar, addr, data);
> > > > > > +
> > > > > > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > > > > > +
> > > > > > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > > > > > +	if (status & STATUS_DOORBELL_SUCCESS)
> > > > > > +		return true;
> > > > > > +
> > > > > > +	return false;
> > > > > > +}
> > > > > > +
> > > > > >  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > > > > >  				    unsigned long arg)
> > > > > >  {
> > > > > > @@ -760,6 +802,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> > > > > >  	case PCITEST_CLEAR_IRQ:
> > > > > >  		ret = pci_endpoint_test_clear_irq(test);
> > > > > >  		break;
> > > > > > +	case PCITEST_DOORBELL:
> > > > > > +		ret = pci_endpoint_test_doorbell(test);
> > > > > > +		break;
> > > > > >  	}
> > > > > >  
> > > > > >  ret:
> > > > > > @@ -887,6 +932,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
> > > > > >  	misc_device->parent = &pdev->dev;
> > > > > >  	misc_device->fops = &pci_endpoint_test_fops;
> > > > > >  
> > > > > > +	test->version = FIELD_GET(PCI_MAGIC_VERSION_MASK,
> > > > > > +				  pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_MAGIC));
> > > > > > +
> > > > > >  	err = misc_register(misc_device);
> > > > > >  	if (err) {
> > > > > >  		dev_err(dev, "Failed to register device\n");
> > > > > > diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> > > > > > index f9c1af8d141b4..479ca1aa3ae0b 100644
> > > > > > --- a/include/uapi/linux/pcitest.h
> > > > > > +++ b/include/uapi/linux/pcitest.h
> > > > > > @@ -20,6 +20,7 @@
> > > > > >  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> > > > > >  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> > > > > >  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > > > > > +#define PCITEST_DOORBELL	_IO('P', 0x11)
> > > > > >  
> > > > > >  #define PCITEST_FLAGS_USE_DMA	0x00000001
> > > > > >  
> > > > > > -- 
> > > > > > 2.34.1
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
